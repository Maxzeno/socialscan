import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/lists/hex_color_list.dart';
import 'package:socialscan/utils/strings.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          network,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ProjectColors.midBlack,
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: networkList.length,
                itemBuilder: (context, index) {
                  // final List data = List.generate(networkList.length, (index){
                  //   return NetworkListTile();
                  // });
                  return NetworkListTile(
                    user: networkList[index],
                    socialMediaList: networkList[index].socialMediaLink!,
                  );
                },
                separatorBuilder: (context, child) => const SizedBox(
                  height: 10,
                ),
              ),
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
  }
}
