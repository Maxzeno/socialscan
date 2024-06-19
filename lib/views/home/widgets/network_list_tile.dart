import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/views/home/screens/view_network_screen.dart';

class NetworkListTile extends StatelessWidget {
  final UserModel user;
  final List<SocialLinkModel> socialMediaList;
  const NetworkListTile(
      {super.key, required this.user, required this.socialMediaList});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ViewNetworkScreen(
            user: user,
            socialMediaList: socialMediaList,
          );
        }));
      },
      child: Container(
        height: 74,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 21,
          // vertical: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).brightness == Brightness.light
              ? ProjectColors.mainGray
              : ProjectColors.cardBlackColor,
          // color: ProjectColors.mainGray,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                user.image.isEmpty
                    ? CircleAvatar(
                        radius: 22,
                        backgroundColor: ProjectColors.mainPurple,
                        child: Center(
                          child: Text(
                            user.fullName
                                .split(' ')[0]
                                .toString()
                                .substring(0, 1),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(user.image),
                      ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 140,
                  child: Column(
          mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.fullName} ',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.profession!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFF696969)
                                  : const Color(0xFFB0B0B0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.end,
                spacing: -4,
                runSpacing: 4,
                // children: [
                //   // SvgPicture.asset(
                //   //   instagramIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     igConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   // SvgPicture.asset(
                //   //   faceBookIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     fbConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   // SvgPicture.asset(
                //   //   linkedInIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     liConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   // SvgPicture.asset(
                //   //   whatsAppIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     wsaConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   // SvgPicture.asset(
                //   //   twitterIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     xConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   NetworkScreenSocialCircle(
                //     bgColor: igConColor,
                //     icon: instagramIcon,
                //   ),
                //   NetworkScreenSocialCircle(
                //     bgColor: fbConColor,
                //     icon: faceBookIcon,
                //   ),
                //   NetworkScreenSocialCircle(
                //     bgColor: liConColor,
                //     icon: linkedInIcon,
                //   ),
                //   NetworkScreenSocialCircle(
                //     bgColor: wsaConColor,
                //     icon: whatsAppIcon,
                //   ),
                //   NetworkScreenSocialCircle(
                //     bgColor: xConColor,
                //     icon: twitterIcon,
                //   ),
                //   // SvgPicture.asset(
                //   //   instagramIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     igConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                //   // SvgPicture.asset(
                //   //   instagramIcon,
                //   //   height: 15,
                //   //   width: 15,
                //   //   colorFilter: const ColorFilter.mode(
                //   //     igConColor,
                //   //     BlendMode.srcIn,
                //   //   ),
                //   // ),
                // ],
                children: socialMediaList.map((social) {
                  return NetworkScreenSocialCircle(
                    bgColor: social.conColor!,
                    icon: social.imagePath!,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkScreenSocialCircle extends StatelessWidget {
  final Color bgColor;
  final String icon;
  const NetworkScreenSocialCircle({
    super.key,
    required this.bgColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          width: Theme.of(context).brightness == Brightness.light ? 2.0 : 1.0,
          color: Theme.of(context).brightness == Brightness.light
              ? ProjectColors.mainGray
              : ProjectColors.networkCircleGrey,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        // borderRadius: BorderRadius.circular(50),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        icon,
        height: 15,
        width: 15,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
