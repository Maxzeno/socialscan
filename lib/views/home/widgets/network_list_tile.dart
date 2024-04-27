import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/lists/hex_color_list.dart';
import 'package:socialscan/utils/strings.dart';

class NetworkListTile extends StatelessWidget {
  const NetworkListTile({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // height: 65,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ProjectColors.mainGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(profileImage),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      davidRay,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "Software Developer",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF696969),
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
              spacing: 8,
              runSpacing: 8,
              children: [
                SvgPicture.asset(
                  instagramIcon,
                  height: 15,
                  width: 15,
                  colorFilter: const ColorFilter.mode(
                    igConColor,
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  faceBookIcon,
                  height: 15,
                  width: 15,
                  colorFilter: const ColorFilter.mode(
                    fbConColor,
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  linkedInIcon,
                  height: 15,
                  width: 15,
                  colorFilter: const ColorFilter.mode(
                    liConColor,
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  whatsAppIcon,
                  height: 15,
                  width: 15,
                  colorFilter: const ColorFilter.mode(
                    wsaConColor,
                    BlendMode.srcIn,
                  ),
                ),
                SvgPicture.asset(
                  twitterIcon,
                  height: 15,
                  width: 15,
                  colorFilter: const ColorFilter.mode(
                    xConColor,
                    BlendMode.srcIn,
                  ),
                ),
                // SvgPicture.asset(
                //   instagramIcon,
                //   height: 15,
                //   width: 15,
                //   colorFilter: const ColorFilter.mode(
                //     igConColor,
                //     BlendMode.srcIn,
                //   ),
                // ),
                // SvgPicture.asset(
                //   instagramIcon,
                //   height: 15,
                //   width: 15,
                //   colorFilter: const ColorFilter.mode(
                //     igConColor,
                //     BlendMode.srcIn,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
