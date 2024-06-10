import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:socialscan/utils/home_social_apps_linear_gradients.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/home/screens/scan_qr_code.dart';
import 'package:socialscan/views/home/screens/view_socials_screen.dart';

import '../../../models/social_link_model.dart';
import '../../../utils/button.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../profile/screens/view_profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  SMIInput<bool>? input;
  // Artboard artboard = Artboard();
  RuntimeArtboard? _artboard;
  StateMachineController? _stateMachineController;

  @override
  void initState() {
    ref.read(userProvider.notifier).updateUserDetails();

    final userNotifier = ref.read(userProvider.notifier);
    userNotifier.checkGoogleUser();
    super.initState();

    rootBundle.load(socialscanHomepageAnimation).then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        print('Artboard loaded: ${artboard.name}');

        // Find and add the state machine controller
        _stateMachineController =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (_stateMachineController != null) {
          artboard.addController(_stateMachineController!);
          setState(() {
            _artboard = artboard as RuntimeArtboard;
          });
        } else {
          print('Failed to find StateMachine');
        }
      },
    ).catchError((error) {
      print('Failed to load Rive file: $error');
    });
  }

// void _onFirstAnimationComplete() {
//     if (!_firstController.isActive) {
//       // First animation finished, move to the second one
//       _artboard!.removeController(_firstController);
//       _firstController.isActiveChanged.removeListener(_onFirstAnimationComplete);

//       _artboard!.addController(_secondController);
//       _secondController.isActiveChanged.addListener(_onSecondAnimationComplete);

//       setState(() {
//         _secondController.isActive = true;
//       });
//     }
//   }

//   void _onSecondAnimationComplete() {
//     if (!_secondController.isActive) {
//       // Second animation finished, move to the third one
//       _artboard!.removeController(_secondController);
//       _secondController.isActiveChanged.removeListener(_onSecondAnimationComplete);

//       _artboard!.addController(_thirdController);
//       _thirdController.isActiveChanged.addListener(_onThirdAnimationComplete);

//       setState(() {
//         _thirdController.isActive = true;
//       });
//     }
//   }

//   void _onThirdAnimationComplete() {
//     if (!_thirdController.isActive) {
//       // Third animation finished, move back to the second one and loop
//       _artboard!.removeController(_thirdController);
//       _thirdController.isActiveChanged.removeListener(_onThirdAnimationComplete);

//       _artboard!.addController(_secondController);
//       _secondController.isActiveChanged.addListener(_onSecondAnimationComplete);

//       setState(() {
//         _secondController.isActive = true;
//       });
//     }
//   }

  List<String> extractLinkUrls(List<SocialLinkModel> socialLinks) {
    List<String> linkUrls = [];
    for (var socialLink in socialLinks) {
      linkUrls.add(socialLink.linkUrl); // Add link URL to the list
    }
    return linkUrls;
  }

  final Map<String, String> greetingLottieIcons = {
    'morning': morningAnimationIcon,
    'afternoon': morningAnimationIcon,
    'evening': eveningAnimationIcon,
  };

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String getLottieIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return greetingLottieIcons['morning']!;
    } else if (hour < 17) {
      return greetingLottieIcons['afternoon']!;
    } else {
      return greetingLottieIcons['evening']!;
    }
  }

  @override
  void dispose() {
    _stateMachineController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    // final userProvider = Provider.of<UserProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    print("Screen Width: $screenWidth");

    final greeting = getGreeting();
    final greetingIcon = getLottieIcon();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: userState.userModel == null
            ? Center(
                child: HeartBeat(
                  preferences: const AnimationPreferences(
                    // duration: Duration(seconds: 2),
                    autoPlay: AnimationPlayStates.Loop,
                  ),
                  child: Image.asset(
                    'assets/images/socialscan_logo_png.png',
                    height: 40,
                  ),
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
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
                                        userState.userModel!.fullName
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // helloDavid,
                                "$greeting, ${userState.userModel!.fullName.split(' ')[0]}",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  // color: ProjectColors.midBlack,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? ProjectColors.bgBlack
                                      : ProjectColors.mainGray,
                                ),
                              ),
                              Text(
                                "Lets keep you connected",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  // color: ProjectColors.midBlack,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? const Color(0xFF24212B).withOpacity(0.5)
                                      : const Color(0xFFF4F4F4)
                                          .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      LottieBuilder.asset(
                        greetingIcon,
                        frameRate: FrameRate.max,
                        repeat: true,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                        // controller: _animation,
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Expanded(
                  //   child: Stack(
                  //     children: [
                  //       SvgPicture.asset(
                  //         dotsImage,
                  //         // color: Colors.grey.shade50,
                  //       ),
                  //       Center(
                  //         child: SvgPicture.asset(
                  //           Theme.of(context).brightness == Brightness.light
                  //               ? homepageImageLight
                  //               : homepageImageDark,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: _artboard == null
                        ? const SizedBox()
                        : Rive(
                            artboard: _artboard!,
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
                      const SizedBox(height: 50),
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
                          height: 94,
                          padding: const EdgeInsets.only(left: 25),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: Theme.of(context).brightness ==
                                        Brightness.light ? null : const DecorationImage(
                              image: AssetImage(
                                "assets/images/view_social_with_dot.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey
                                    : Colors.transparent),
                            // gradient:
                            //     Theme.of(context).brightness == Brightness.light
                            //         ? LinearGradient.lerp(lg3, lg4, 0.2)
                            //         : LinearGradient.lerp(lg1, lg2, 0.2),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "View your social apps",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          // color: ProjectColors.midBlack,
                                          // color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          margin: const EdgeInsets.only(
                                            right: 25,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: ProjectColors.mainPurple,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.chevron_right_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   right: 0,
                              //   child: SvgPicture.asset(
                              //     blocksImage,
                              //     color: Colors.grey.shade900,
                              //   ),
                              // ),
                              // SvgPicture.asset(
                              //     "assets/svg_icons/view_social_with_dot.svg",
                              //     // color: Colors.grey.shade900,
                              //     width: double.infinity,
                              //     height: double.infinity,
                              //   ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
