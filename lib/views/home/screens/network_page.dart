import 'package:flutter/material.dart';
// import 'package:flutter_animator/animation/animation_preferences.dart';
// import 'package:flutter_animator/animation/animator_play_states.dart';
// import 'package:flutter_animator/widgets/attention_seekers/heart_beat.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/lists/hex_color_list.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/network_list_tile.dart';
import 'package:socialscan/views/home/widgets/text_tile_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../models/network_model.dart';

List<UserModel> networkList = [
  UserModel(
    fullName: "David Ray",
    // lastName: "Ray",
    phoneNumber: "+2349072571890",
    profession: "Software Developer",
    email: "email@gmail.com",
    id: "0",
    image: profileImage,
    socialMediaLink: [
      SocialLinkModel(
        text: 'Facebook',
        imagePath: faceBookIcon,
        id: "0",
        conColor: fbConColor,
        iconColor: fbIconColor,
        linkUrl: 'https://www.facebook.com/aghazie.emeka',
      ),
      SocialLinkModel(
        text: 'X',
        imagePath: twitterIcon,
        id: "2",
        conColor: xConColor,
        iconColor: xIconColor,
        linkUrl: 'https://twitter.com/markuiux',
      ),
      SocialLinkModel(
        text: 'LinkedIn',
        imagePath: linkedInIcon,
        id: "0",
        conColor: liConColor,
        iconColor: liIconColor,
        linkUrl: 'https://www.linkedin.com/in/chineduemmanuel/',
      ),
    ],
  ),
  UserModel(
    fullName: "Mellisa Degrassi",
    // lastName: "Degrassi",
    phoneNumber: "",
    profession: "Data Analyst",
    email: "mellisa@gmail.com",
    id: "1",
    image: profileImage2,
    socialMediaLink: [
      SocialLinkModel(
        text: 'Instagram',
        imagePath: instagramIcon,
        id: "0",
        conColor: igConColor,
        iconColor: igIconColor,
        linkUrl: 'https://www.instagram.com/neeferriouss/',
      ),
      SocialLinkModel(
        text: 'Facebook',
        imagePath: faceBookIcon,
        id: "1",
        conColor: fbConColor,
        iconColor: fbIconColor,
        linkUrl: 'https://www.facebook.com/teemah.eunwoo',
      ),
    ],
  ),
  UserModel(
    fullName: "Henry Lionel",
    // lastName: "Lionel",
    phoneNumber: "",
    profession: "Scientist",
    email: "",
    id: "2",
    image: profileImage3,
    socialMediaLink: [
      SocialLinkModel(
        text: 'GitHub',
        imagePath: githubIcon,
        id: "0",
        conColor: ghConColor,
        iconColor: ghIconColor,
        linkUrl: 'https://github.com/Henryikenna',
      ),
      SocialLinkModel(
        text: 'LinkedIn',
        imagePath: linkedInIcon,
        id: "1",
        conColor: liConColor,
        iconColor: liIconColor,
        linkUrl: 'https://www.linkedin.com/in/henry-unegbu-832838254/',
      ),
      SocialLinkModel(
        text: 'WhatsApp',
        imagePath: whatsAppIcon,
        id: "2",
        conColor: wsaConColor,
        iconColor: wsaIconColor,
        linkUrl: 'https://wa.me/+2349159737704',
      ),
    ],
  ),
];

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        // backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          network,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? ProjectColors.midBlack
                : ProjectColors.mainGray,
            // color: ProjectColors.midBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          // vertical: 16.0,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder(
            stream: FirebaseService().getAllNetworkUsers(),
            builder: (context, AsyncSnapshot<List<NetWorkModel>> snapshot) {
              if (snapshot.hasData) {
                final results = snapshot.data;

                if (results!.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: const Center(
                      child: Text("There's nothing here."),
                    ),
                  );
                }
                final networkTime =
                    formatTimestampToDay(results.first.dateTime);

                print('Time ===> ${results.first.dateTime}');
                print('Hello network');
                print('Network data ====> $results');

                return results.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: const Center(
                          child: Text("There's nothing here."),
                        ),
                      )
                    : Column(
                        children: [
                          TextTileWidget(
                            text: networkTime ?? '',
                            icon: SvgPicture.asset(
                              searchIcon,
                              height: 21,
                              width: 21,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              final data = results[index];
                              print('This data $data');
                              // final List data = List.generate(networkList.length, (index){
                              //   return NetworkListTile();
                              // });
                              return NetworkListTile(
                                user: data.userModel,
                                socialMediaList:
                                    data.userModel.socialMediaLink!,
                              );
                            },
                            separatorBuilder: (context, child) =>
                                const SizedBox(
                              height: 8,
                            ),
                          ),
                        ],
                      );
              } else {
                // return SizedBox(
                //   height: MediaQuery.of(context).size.height - 200,
                //   child: Center(
                //     child: HeartBeat(
                //       preferences: const AnimationPreferences(
                //         // duration: Duration(seconds: 2),
                //         autoPlay: AnimationPlayStates.Loop,
                //       ),
                //       child: Image.asset(
                //         socialIcon,
                //         height: 30,
                //       ),
                //     ),
                //   ),
                // );

                return Skeletonizer(
                  child: ListView.separated(
                    itemCount: 3,
                    shrinkWrap: true,
                    separatorBuilder: (context, child) => const SizedBox(
                      height: 8,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TextTileWidget(
                            text: 'Today',
                            icon: SvgPicture.asset(
                              searchIcon,
                              height: 21,
                              width: 21,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return NetworkListTile(
                                user: UserModel(
                                  fullName: "Henry Unegbu",
                                  phoneNumber: "",
                                  profession: "Scientist",
                                  email: "",
                                  id: "",
                                  image: profileImage3,
                                  socialMediaLink: [],
                                ),
                                socialMediaList: const [
                                  // SocialLinkModel(
                                  //   text: 'GitHub',
                                  //   imagePath: "",
                                  //   id: "0",
                                  //   conColor: Colors.transparent,
                                  //   iconColor: Colors.transparent,
                                  //   linkUrl: 'https://github.com/Henryikenna',
                                  // ),
                                  // SocialLinkModel(
                                  //   text: 'LinkedIn',
                                  //   imagePath: "",
                                  //   id: "1",
                                  //   conColor: Colors.transparent,
                                  //   iconColor: Colors.transparent,
                                  //   linkUrl: '',
                                  // ),
                                  // SocialLinkModel(
                                  //   text: 'WhatsApp',
                                  //   imagePath: "",
                                  //   id: "2",
                                  //   conColor: Colors.transparent,
                                  //   iconColor: Colors.transparent,
                                  //   linkUrl: '',
                                  // ),
                                ],
                              );
                            },
                            separatorBuilder: (context, child) =>
                                const SizedBox(
                              height: 8,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
