import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/lists/hex_color_list.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/theme_provider.dart';
import 'package:socialscan/views/home/widgets/network_list_tile.dart';
import 'package:socialscan/views/home/widgets/text_tile_widget.dart';

List<UserModel> networkList = [
  UserModel(
    firstName: "David",
    lastName: "Ray",
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
    firstName: "Mellisa",
    lastName: "Degrassi",
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
    firstName: "Henry",
    lastName: "Lionel",
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
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _){
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: themeProvider.themeMode == ThemeMode.light ? Colors.white : ProjectColors.midBlack,
          elevation: 0.0,
          title: Text(
            network,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: themeProvider.themeMode == ThemeMode.light ? ProjectColors.midBlack : Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            // vertical: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextTileWidget(
                  text: today,
                  icon: SvgPicture.asset(
                    searchIcon,
                    height: 21,
                    width: 21,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // networkLists(3),
                StreamBuilder(
                  stream: FirebaseService().getAllNetworkUsers(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (snapshot.hasData) {
                      final results = snapshot.data;
                      print('Network data ====> $results');
      
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: results!.length,
                        itemBuilder: (context, index) {
                          final data = results[index];
                          // final List data = List.generate(networkList.length, (index){
                          //   return NetworkListTile();
                          // });
                          return NetworkListTile(
                            user: data,
                            socialMediaList: data.socialMediaLink!,
                          );
                        },
                        separatorBuilder: (context, child) => const SizedBox(
                          height: 10,
                        ),
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
      
                // StreamBuilder<QuerySnapshot>(
                //   stream:
                //       FirebaseFirestore.instance.collection('users').snapshots(),
                //   builder: (BuildContext context,
                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                //     if (snapshot.hasError) {
                //       return const Text('Something went wrong');
                //     }
      
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Text("Loading");
                //     }
      
                //     return ListView(
                //       shrinkWrap: true,
                //       children:
                //           snapshot.data!.docs.map((DocumentSnapshot document) {
                //         Map<String, dynamic> data =
                //             document.data()! as Map<String, dynamic>;
                //         return ListTile(
                //           title: Text(data['firstName'] + ' ' + data['lastName']),
                //           subtitle: Text(data['email']),
                //         );
                //       }).toList(),
                //     );
                //   },
                // ),
                const SizedBox(
                  height: 25,
                ),
                TextTileWidget(
                  text: yesterday,
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 18,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: networkList.length,
                  itemBuilder: (context, index) => NetworkListTile(
                    user: networkList[index],
                    socialMediaList: networkList[index].socialMediaLink!,
                  ),
                  separatorBuilder: (context, child) => const SizedBox(
                    height: 10,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    });
  }
}
