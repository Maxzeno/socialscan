import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/home/screens/qr_code_screen.dart';
import 'package:socialscan/views/home/screens/scan_qr_code.dart';
import 'package:socialscan/views/home/screens/socials_page.dart';
import 'package:socialscan/views/home/screens/view_socials_screen.dart';

import '../../../models/social_link_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/lists/added_socials_list.dart';
import '../../../utils/lists/selected_socials_to_send_list.dart';
import '../../../utils/services/firebase_services.dart';
import '../../../utils/strings.dart';
import '../../profile/screens/view_profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    ref.read(userProvider.notifier).updateUserDetails();

    final userNotifier = ref.read(userProvider.notifier);
    userNotifier.checkGoogleUser();
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
  }

  List<String> extractLinkUrls(List<SocialLinkModel> socialLinks) {
    List<String> linkUrls = [];
    for (var socialLink in socialLinks) {
      linkUrls.add(socialLink.linkUrl); // Add link URL to the list
    }
    return linkUrls;
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    // final userProvider = Provider.of<UserProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    print("Screen Width: $screenWidth");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: userState.userModel == null
            ? const Center()
            : StreamBuilder(
                stream: FirebaseService().getUserDetailsAndLinks(),
                builder: (context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.hasData) {
                    final results = snapshot.data;
                    userdata.add(results!);
                    print('User data ====> $userdata');

                    return Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const ViewProfileScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ProjectColors.mainPurple,
                                ),
                                child: (userState.userModel!.image.isEmpty) &&
                                        userState.image == null
                                    ? Center(
                                        child: Text(
                                          userState.userModel!.firstName
                                              .substring(0, 1),
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : userState.image != null &&
                                            userState.image!.isNotEmpty
                                        ? ClipOval(
                                            child: Image.memory(
                                              userState.image!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              userState.userModel!.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              // helloDavid,
                              "Hello ${userState.userModel!.firstName}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                // color: ProjectColors.midBlack,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? ProjectColors.bgBlack
                                    : ProjectColors.mainGray,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        Expanded(
                          child: Center(
                            child: SvgPicture.asset(
                              Theme.of(context).brightness == Brightness.light
                                  ? homepageImageLight
                                  : homepageImageDark,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ButtonTile(
                              width: screenWidth / 2,
                              text: "Scan QR Code",
                              boxRadius: 80,
                              // icon: SvgPicture.asset(
                              //   connectIcon,
                              //   height: 24,
                              //   width: 24,
                              // ),
                              onTap: () {
                                // List<String> allLinks = extractLinkUrls(socialLinks);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ScanQrCode(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 56),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const ViewSocialsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 90,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF7F1F9A),
                                      Color(0xFF2B0A34),
                                    ],
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      // helloDavid,
                                      "View your social apps",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        // color: ProjectColors.midBlack,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: HeartBeat(
                        preferences: const AnimationPreferences(
                          // duration: Duration(seconds: 2),
                          autoPlay: AnimationPlayStates.Loop,
                        ),
                        child: Image.asset(
                          'assets/images/socialscan_logo_png.png',
                          height: 30,
                        ),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
