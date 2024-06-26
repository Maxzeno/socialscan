import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/home/screens/socials_page.dart';

import '../../../models/social_link_model.dart';
import '../../../models/user_model.dart';
import '../../../utils/lists/added_socials_list.dart';
import '../../../utils/lists/selected_socials_to_send_list.dart';
import '../../../utils/services/firebase_services.dart';
import '../../../utils/strings.dart';
import 'qr_code_screen.dart';

class ViewSocialsScreen extends ConsumerStatefulWidget {
  const ViewSocialsScreen({super.key});

  @override
  ConsumerState<ViewSocialsScreen> createState() => _ViewSocialsScreenState();
}

class _ViewSocialsScreenState extends ConsumerState<ViewSocialsScreen>
    with SingleTickerProviderStateMixin {
  // late TabController _tabController;

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

    // final screenWidth = MediaQuery.of(context).size.width;

    // bool isChecked = false;
    // bool isChecked2 = false;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            // color: Colors.black,
          ),
        ),
        title: Text(
          'Your Social Apps',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
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
                        // Row(
                        //         children: [
                        //           InkWell(
                        //             onTap: () {
                        //               Navigator.push(
                        //                 context,
                        //                 CupertinoPageRoute(
                        //                   builder: (_) =>
                        //                       const ViewProfileScreen(),
                        //                 ),
                        //               );
                        //             },
                        //             child: Container(
                        //               height: 42,
                        //               width: 42,
                        //               decoration: const BoxDecoration(
                        //                 shape: BoxShape.circle,
                        //                 color: ProjectColors.mainPurple,
                        //               ),
                        //               child: (userState
                        //                           .userModel!.image.isEmpty) &&
                        //                       userState.image == null
                        //                   ? Center(
                        //                       child: Text(
                        //                         userState.userModel!.firstName
                        //                             .substring(0, 1),
                        //                         style: const TextStyle(
                        //                           fontSize: 17,
                        //                           color: Colors.white,
                        //                         ),
                        //                       ),
                        //                     )
                        //                   : userState.image != null &&
                        //                           userState.image!.isNotEmpty
                        //                       ? ClipOval(
                        //                           child: Image.memory(
                        //                             userState.image!,
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         )
                        //                       : ClipOval(
                        //                           child: Image.network(
                        //                             userState.userModel!.image,
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                         ),
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 10,
                        //           ),
                        //           Text(
                        //             // helloDavid,
                        //             "Hello ${userState.userModel!.firstName}",
                        //             style: TextStyle(
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.w600,
                        //               // color: ProjectColors.midBlack,
                        //               color: Theme.of(context).brightness ==
                        //                       Brightness.light
                        //                   ? ProjectColors.bgBlack
                        //                   : ProjectColors.mainGray,
                        //             ),
                        //           ),
                        //           // const Spacer(),
                        //           // InkWell(
                        //           //   onTap: () {
                        //           //     Navigator.push(
                        //           //       context,
                        //           //       CupertinoPageRoute(
                        //           //         builder: (_) => const SettingScreen(),
                        //           //       ),
                        //           //     );
                        //           //   },
                        //           //   child: SvgPicture.asset(
                        //           //     settingsIcon,
                        //           //     height: 24,
                        //           //     width: 24,
                        //           //   ),
                        //           // ),
                        //         ],
                        //       ),

                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            // mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              // const SizedBox(
                              //   height: 30,
                              // ),
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
                              SocialsPage(),
                            ],
                          ),
                        ),
                        // selectedSocialsToSendList.isNotEmpty
                        // selectedCount > 0

                        ButtonTile(
                          width: double.infinity,
                          text: connect,
                          boxRadius: 8,
                          color: selectedSocialsToSendList.isNotEmpty
                              ? ProjectColors.mainPurple
                              : ProjectColors.mainGray,
                          textColor: selectedSocialsToSendList.isNotEmpty
                              ? Colors.white
                              : ProjectColors.cardBlackColor.withOpacity(0.6),
                          icon: Icon(
                            Icons.qr_code,
                            color: selectedSocialsToSendList.isNotEmpty
                                ? Colors.white
                                : ProjectColors.cardBlackColor.withOpacity(0.6),
                          ),
                          onTap: selectedSocialsToSendList.isNotEmpty
                              ? () {
                                  // List<String> allLinks = extractLinkUrls(socialLinks);
                                  List<String> allLinks = extractLinkUrls(
                                      selectedSocialsToSendList);

                                  print('all Links ====> $allLinks');

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      bool isChecked = false;
                                      bool isChecked2 = false;

                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog.adaptive(
                                            insetPadding:
                                                const EdgeInsets.all(20),
                                            backgroundColor: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : ProjectColors.cardBlackColor,
                                            titlePadding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 30,
                                              bottom: 15,
                                            ),
                                            actionsPadding:
                                                const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title: const Text(
                                              'While sharing...',
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xFFCCCCCC),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            content: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child: Checkbox(
                                                          value: isChecked,
                                                          activeColor:
                                                              ProjectColors
                                                                  .mainPurple,
                                                          side: BorderSide(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? const Color(
                                                                    0x80000000)
                                                                : ProjectColors
                                                                    .mainGray,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              isChecked = val!;
                                                            });
                                                          },
                                                          checkColor:
                                                              Colors.white,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Include Email",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                            userState.userModel!
                                                                .email,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? Colors
                                                                      .black38
                                                                  : ProjectColors
                                                                      .mainGray
                                                                      .withOpacity(
                                                                          0.7),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 35),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child: Checkbox(
                                                          value: isChecked2,
                                                          activeColor:
                                                              ProjectColors
                                                                  .mainPurple,
                                                          side: BorderSide(
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? const Color(
                                                                    0x80000000)
                                                                : ProjectColors
                                                                    .mainGray,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              isChecked2 = val!;
                                                            });
                                                          },
                                                          checkColor:
                                                              Colors.white,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                          visualDensity:
                                                              VisualDensity
                                                                  .compact,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            "Include phone number",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(
                                                            userState.userModel!
                                                                .phoneNumber
                                                                .replaceAll(
                                                                    '-', ''),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? Colors
                                                                      .black38
                                                                  : ProjectColors
                                                                      .mainGray
                                                                      .withOpacity(
                                                                          0.7),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ButtonTile(
                                                onTap: () {
                                                  // List<String> allLinks =
                                                  //     extractLinkUrls(
                                                  //         selectedSocialsToSendList);

                                                  // print(
                                                  //     'all Links ====> $allLinks');

                                                  // setState(() {
                                                  //   selectedSocialsToSendList
                                                  //       .clear();
                                                  // });

                                                  Navigator.pop(context);

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          QrCodeScreen(
                                                        qrData: results,
                                                        // context: context,
                                                        isEmailSelectedToBeSent:
                                                            isChecked,
                                                        isPhoneNumberSelectedToBeSent:
                                                            isChecked2,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                width: double.infinity,
                                                text: "Continue",
                                                boxRadius: 10,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                }
                              : null,
                        ),
                        // : ButtonTile(
                        //     width: double.infinity,
                        //     text: "Scan QR Code",
                        //     boxRadius: 8,
                        //     icon: SvgPicture.asset(
                        //       connectIcon,
                        //       height: 24,
                        //       width: 24,
                        //     ),
                        //     onTap: () {
                        //       // List<String> allLinks = extractLinkUrls(socialLinks);
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) => const ScanQrCode(),
                        //         ),
                        //       );
                        //     },
                        //   ),
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

// if (snapshot.connectionState == ConnectionState.waiting) {
//   return Center(
//     child: HeartBeat(
//       preferences: const AnimationPreferences(
//         // duration: Duration(seconds: 2),
//         autoPlay: AnimationPlayStates.Loop,
//       ),
//       child: Image.asset(
//         'assets/images/socialscan_logo_png.png',
//         height: 30,
//       ),
//     ),
//   );
// } else {
//   if (snapshot.hasData) {
//     final results = snapshot.data;
//     userdata.add(results!);
//     print('User data ====> $userdata');

//     return Column(
//       children: [
//         Expanded(
//           child: ListView(
//             physics: const BouncingScrollPhysics(),
//             // mainAxisSize: MainAxisSize.min,
//             // crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (_) =>
//                               const ViewProfileScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       height: 42,
//                       width: 42,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: ProjectColors.mainPurple,
//                       ),
//                       child: (userState.userModel!.image
//                                   .isEmpty) &&
//                               userState.image == null
//                           ? Center(
//                               child: Text(
//                                 userState.userModel!.firstName
//                                     .substring(0, 1),
//                                 style: const TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             )
//                           : userState.image != null &&
//                                   userState.image!.isNotEmpty
//                               ? ClipOval(
//                                   child: Image.memory(
//                                     userState.image!,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )
//                               : ClipOval(
//                                   child: Image.network(
//                                     userState
//                                         .userModel!.image,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     // helloDavid,
//                     "Hello ${userState.userModel!.firstName}",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       // color: ProjectColors.midBlack,
//                       color: Theme.of(context).brightness ==
//                               Brightness.light
//                           ? ProjectColors.bgBlack
//                           : ProjectColors.mainGray,
//                     ),
//                   ),
//                   // const Spacer(),
//                   // InkWell(
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       CupertinoPageRoute(
//                   //         builder: (_) => const SettingScreen(),
//                   //       ),
//                   //     );
//                   //   },
//                   //   child: SvgPicture.asset(
//                   //     settingsIcon,
//                   //     height: 24,
//                   //     width: 24,
//                   //   ),
//                   // ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // TabsContainerWidget(
//               //   tabController: _tabController,
//               // ),
//               // const SizedBox(
//               //   height: 25,
//               // ),
//               // Expanded(
//               //   // height: MediaQuery.of(context).size.height,
//               //   child: TabBarView(
//               //     controller: _tabController,
//               //     children: const [
//               //       SocialsPage(),
//               //       NetworkPage(),
//               //     ],
//               //   ),
//               // ),
//               const SocialsPage(),
//             ],
//           ),
//         ),
//         selectedSocialsToSendList.isNotEmpty
//             // selectedCount > 0

//             ? ButtonTile(
//                 width: double.infinity,
//                 text: connect,
//                 boxRadius: 8,
//                 icon: const Icon(
//                   Icons.qr_code,
//                   color: Colors.white,
//                 ),
//                 onTap: () {
//                   // List<String> allLinks = extractLinkUrls(socialLinks);
//                   List<String> allLinks = extractLinkUrls(
//                       selectedSocialsToSendList);

//                   print('all Links ====> $allLinks');

//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog.adaptive(
//                         insetPadding:
//                             const EdgeInsets.all(20),
//                         // contentPadding:
//                         //     const EdgeInsets.all(20),
//                         titlePadding: const EdgeInsets.only(
//                           left: 20,
//                           right: 20,
//                           top: 30,
//                           bottom: 15,
//                         ),
//                         actionsPadding: const EdgeInsets.only(
//                           left: 20,
//                           right: 20,
//                           bottom: 20,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(16),
//                         ),
//                         title: const Text(
//                           'While sharing...',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Color(0xFFCCCCCC),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         content: SizedBox(
//                           width: screenWidth * 0.8,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisSize:
//                                     MainAxisSize.min,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: Checkbox(
//                                       value: _isChecked,
//                                       activeColor:
//                                           ProjectColors
//                                               .mainPurple,
//                                       side: const BorderSide(
//                                         color:
//                                             Color(0x80000000),
//                                       ),
//                                       shape:
//                                           RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius
//                                                 .circular(4),
//                                       ),
//                                       onChanged: (val) {
//                                         setState(() {
//                                           _isChecked =
//                                               !_isChecked;
//                                         });
//                                       },
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize
//                                               .shrinkWrap,
//                                       visualDensity:
//                                           VisualDensity
//                                               .compact,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Column(
//                                     mainAxisSize:
//                                         MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                     children: [
//                                       const Text(
//                                         "Include Email",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight:
//                                               FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                           height: 4),
//                                       Text(
//                                         userState
//                                             .userModel!.email,
//                                         style:
//                                             const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight:
//                                               FontWeight.w500,
//                                           color:
//                                               Colors.black38,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 35),
//                               Row(
//                                 mainAxisSize:
//                                     MainAxisSize.min,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: Checkbox(
//                                       value: _isChecked2,
//                                       activeColor:
//                                           ProjectColors
//                                               .mainPurple,
//                                       side: const BorderSide(
//                                         color:
//                                             Color(0x80000000),
//                                       ),
//                                       shape:
//                                           RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius
//                                                 .circular(4),
//                                       ),
//                                       onChanged: (val) {
//                                         setState(() {
//                                           _isChecked2 =
//                                               !_isChecked2;
//                                         });
//                                       },
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize
//                                               .shrinkWrap,
//                                       visualDensity:
//                                           VisualDensity
//                                               .compact,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Column(
//                                     mainAxisSize:
//                                         MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment
//                                             .start,
//                                     children: [
//                                       const Text(
//                                         "Include phone number",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight:
//                                               FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                           height: 4),
//                                       Text(
//                                         userState.userModel!
//                                             .phoneNumber
//                                             .replaceAll(
//                                                 '-', ''),
//                                         style:
//                                             const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight:
//                                               FontWeight.w500,
//                                           color:
//                                               Colors.black38,
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         actions: [
//                           ButtonTile(
//                             onTap: () {},
//                             width: double.infinity,
//                             text: "Continue",
//                             boxRadius: 10,
//                           ),
//                         ],
//                       );

//                       //             Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (_) =>
//                       //         QrCodeScreen(
//                       //           qrData: results,
//                       //         ),
//                       //   ),
//                       // );
//                     },
//                   );
//                 },
//               )
//             : ButtonTile(
//                 width: double.infinity,
//                 text: "Scan QR Code",
//                 boxRadius: 8,
//                 icon: SvgPicture.asset(
//                   connectIcon,
//                   height: 24,
//                   width: 24,
//                 ),
//                 onTap: () {
//                   // List<String> allLinks = extractLinkUrls(socialLinks);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const ScanQrCode(),
//                     ),
//                   );
//                 },
//               ),
//       ],
//     );
//   } else {
//     return Center(
//       child: HeartBeat(
//         preferences: const AnimationPreferences(
//           // duration: Duration(seconds: 2),
//           autoPlay: AnimationPlayStates.Loop,
//         ),
//         child: Image.asset(
//           'assets/images/socialscan_logo_png.png',
//           height: 30,
//         ),
//       ),
//     );
//   }
// }

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => QrCodeScreen(
//       qrData: results,
//     ),
//   ),
// );

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
