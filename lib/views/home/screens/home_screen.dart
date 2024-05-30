import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/home/screens/qr_code_screen.dart';
import 'package:socialscan/views/home/screens/scan_qr_code.dart';
import 'package:socialscan/views/home/screens/socials_page.dart';

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
  // late TabController _tabController;

  final bool _isChecked = false;
  final bool _isChecked2 = false;

  @override
  void initState() {
    // addData();
    // ref.read(userProvider.notifier).updateUserDetails();
    ref.read(userProvider.notifier).updateUserDetails();

    final userNotifier = ref.read(userProvider.notifier);
    userNotifier.checkGoogleUser();
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
  }

  // addData() async {
  //   UserProvider userModel = Provider.of<UserProvider>(context, listen: false);
  //   await userModel.updateUserDetails();

  // await logicModelProvider.transactionsStream('expense');
  // await logicModelProvider.transactionsStream('income');
  // }

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

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   // leadingWidth: 20,
      //   elevation: 0.0,
      //   leading: Center(
      //     child: CircleAvatar(
      //       radius: 20,
      //       backgroundImage: NetworkImage(profileImage),
      //     ),
      //   ),
      //   title: Text(
      //     helloDavid,
      //     style: TextStyle(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //       color: ProjectColors.midBlack,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: SvgPicture.asset(
      //         settingsIcon,
      //         height: 24,
      //         width: 24,
      //       ),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: userState.userModel == null
            ? const Center(child: CircularProgressIndicator())
            : StreamBuilder(
                stream: FirebaseService().getUserDetailsAndLinks(),
                builder: (context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.hasData) {
                    final results = snapshot.data;
                    userdata.add(results!);
                    print('User data ====> $userdata');

                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            // mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) =>
                                              const ViewProfileScreen(),
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
                                      child: (userState
                                                  .userModel!.image.isEmpty) &&
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
                                  // const Spacer(),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       CupertinoPageRoute(
                                  //         builder: (_) => const SettingScreen(),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: SvgPicture.asset(
                                  //     settingsIcon,
                                  //     height: 24,
                                  //     width: 24,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // TabsContainerWidget(
                              //   tabController: _tabController,
                              // ),
                              // const SizedBox(
                              //   height: 25,
                              // ),
                              // Expanded(
                              //   // height: MediaQuery.of(context).size.height,
                              //   child: TabBarView(
                              //     controller: _tabController,
                              //     children: const [
                              //       SocialsPage(),
                              //       NetworkPage(),
                              //     ],
                              //   ),
                              // ),
                              const SocialsPage(),
                            ],
                          ),
                        ),
                        selectedSocialsToSendList.isNotEmpty
                            // selectedCount > 0

                            ? ButtonTile(
                                width: double.infinity,
                                text: connect,
                                boxRadius: 8,
                                icon: const Icon(
                                  Icons.qr_code,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  // List<String> allLinks = extractLinkUrls(socialLinks);
                                  List<String> allLinks = extractLinkUrls(
                                      selectedSocialsToSendList);

                                  print('all Links ====> $allLinks');

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => QrCodeScreen(
                                        qrData: results,
                                      ),
                                    ),
                                  );
                                })
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog.adaptive(
                            //           insetPadding: const EdgeInsets.all(20),
                            //           // contentPadding:
                            //           //     const EdgeInsets.all(20),
                            //           titlePadding: const EdgeInsets.only(
                            //             left: 20,
                            //             right: 20,
                            //             top: 30,
                            //             bottom: 15,
                            //           ),
                            //           actionsPadding: const EdgeInsets.only(
                            //             left: 20,
                            //             right: 20,
                            //             bottom: 20,
                            //           ),
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(16),
                            //           ),
                            //           title: const Text(
                            //             'While sharing...',
                            //             style: TextStyle(
                            //               fontSize: 24,
                            //               color: Color(0xFFCCCCCC),
                            //               fontWeight: FontWeight.w600,
                            //             ),
                            //           ),
                            //           content: SizedBox(
                            //             width: screenWidth * 0.8,
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Row(
                            //                   mainAxisSize: MainAxisSize.min,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.start,
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     SizedBox(
                            //                       height: 20,
                            //                       width: 20,
                            //                       child: Checkbox(
                            //                         value: _isChecked,
                            //                         activeColor: ProjectColors
                            //                             .mainPurple,
                            //                         side: const BorderSide(
                            //                           color:
                            //                               Color(0x80000000),
                            //                         ),
                            //                         shape:
                            //                             RoundedRectangleBorder(
                            //                           borderRadius:
                            //                               BorderRadius
                            //                                   .circular(4),
                            //                         ),
                            //                         onChanged: (val) {
                            //                           setState(() {
                            //                             _isChecked =
                            //                                 !_isChecked;
                            //                           });
                            //                         },
                            //                         materialTapTargetSize:
                            //                             MaterialTapTargetSize
                            //                                 .shrinkWrap,
                            //                         visualDensity:
                            //                             VisualDensity.compact,
                            //                       ),
                            //                     ),
                            //                     const SizedBox(width: 10),
                            //                     Column(
                            //                       mainAxisSize:
                            //                           MainAxisSize.min,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment
                            //                               .start,
                            //                       children: [
                            //                         const Text(
                            //                           "Include Email",
                            //                           style: TextStyle(
                            //                             fontSize: 16,
                            //                             fontWeight:
                            //                                 FontWeight.w600,
                            //                           ),
                            //                         ),
                            //                         const SizedBox(height: 4),
                            //                         Text(
                            //                           userState
                            //                               .userModel!.email,
                            //                           style: const TextStyle(
                            //                             fontSize: 12,
                            //                             fontWeight:
                            //                                 FontWeight.w500,
                            //                             color: Colors.black38,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     )
                            //                   ],
                            //                 ),
                            //                 const SizedBox(height: 35),
                            //                 Row(
                            //                   mainAxisSize: MainAxisSize.min,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.start,
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     SizedBox(
                            //                       height: 20,
                            //                       width: 20,
                            //                       child: Checkbox(
                            //                         value: _isChecked2,
                            //                         activeColor: ProjectColors
                            //                             .mainPurple,
                            //                         side: const BorderSide(
                            //                           color:
                            //                               Color(0x80000000),
                            //                         ),
                            //                         shape:
                            //                             RoundedRectangleBorder(
                            //                           borderRadius:
                            //                               BorderRadius
                            //                                   .circular(4),
                            //                         ),
                            //                         onChanged: (val) {
                            //                           setState(() {
                            //                             _isChecked2 =
                            //                                 !_isChecked2;
                            //                           });
                            //                         },
                            //                         materialTapTargetSize:
                            //                             MaterialTapTargetSize
                            //                                 .shrinkWrap,
                            //                         visualDensity:
                            //                             VisualDensity.compact,
                            //                       ),
                            //                     ),
                            //                     const SizedBox(width: 10),
                            //                     Column(
                            //                       mainAxisSize:
                            //                           MainAxisSize.min,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment
                            //                               .start,
                            //                       children: [
                            //                         const Text(
                            //                           "Include phone number",
                            //                           style: TextStyle(
                            //                             fontSize: 16,
                            //                             fontWeight:
                            //                                 FontWeight.w600,
                            //                           ),
                            //                         ),
                            //                         const SizedBox(height: 4),
                            //                         Text(
                            //                           userState.userModel!
                            //                               .phoneNumber
                            //                               .replaceAll(
                            //                                   '-', ''),
                            //                           style: const TextStyle(
                            //                             fontSize: 12,
                            //                             fontWeight:
                            //                                 FontWeight.w500,
                            //                             color: Colors.black38,
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     )
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //           actions: const [
                            //             ButtonTile(
                            //               width: double.infinity,
                            //               text: "Continue",
                            //               boxRadius: 10,
                            //             ),
                            //           ],
                            //         );
                            //
                            //         //             Navigator.push(
                            //         //   context,
                            //         //   MaterialPageRoute(
                            //         //     builder: (_) =>
                            //         //         QrCodeScreen(
                            //         //           qrData: results,
                            //         //         ),
                            //         //   ),
                            //         // );
                            //       },
                            //     );
                            //   },
                            // )
                            : ButtonTile(
                                width: double.infinity,
                                text: "Scan QR Code",
                                boxRadius: 8,
                                icon: SvgPicture.asset(
                                  connectIcon,
                                  height: 24,
                                  width: 24,
                                ),
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
                      ],
                    );
                  } else {
                    return const Center();
                  }
                },
              ),
      ),
    );
  }
}
