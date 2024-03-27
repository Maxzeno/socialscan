import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/social_media_tile.dart';

class SocialListsWidget extends StatelessWidget {
  const SocialListsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 2.3 / 2.1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      shrinkWrap: true,
      itemCount: socialLinks.length + 1,
      itemBuilder: (context, index) {
        if (index == socialLinks.length) {
          return GestureDetector(
            onTap: () {
              // print(MediaQuery.of(context).size.height);
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: screenHeight * 0.45,
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenHeight / 43,
                      vertical: screenHeight / 35,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              strokeWidth: 1.5,
              dashPattern: const [8, 8],
              color: ProjectColors.midBlack.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: ProjectColors.midBlack.withOpacity(0.1),
                      child: SvgPicture.asset(
                        addIcon,
                        height: 22,
                        width: 22,
                        color: ProjectColors.midBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      addNew,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ProjectColors.midBlack.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        final data = socialLinks[index];
        return SocialMediaTile(
            socialImage: data.imagePath,
            socialIconColor: data.iconColor,
            conColor: data.conColor,
            socialText: data.text);
      },
    );
  }
}
