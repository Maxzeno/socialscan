import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class SocialMediaTile extends StatelessWidget {
  final String socialText;
  final String socialImage;
  final Color socialIconColor;
  final Color conColor;
  final bool isSocialChecked;
  final void Function(bool?) onSelected;

  const SocialMediaTile(
      {super.key,
      required this.socialImage,
      required this.socialIconColor,
      required this.conColor,
      required this.socialText, required this.isSocialChecked, required this.onSelected,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 184,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: conColor.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 53,
                width: 53,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: socialIconColor,
                  border: Border.all(width: 1, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      // blurStyle: BlurStyle.outer,
                      color: socialIconColor,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    socialImage,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                socialText,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ProjectColors.midBlack.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.11,
              child: Checkbox.adaptive(
                value: isSocialChecked,
                onChanged: onSelected,
                activeColor: ProjectColors.mainPurple,
                checkColor: Colors.white,
                side: const BorderSide(color: ProjectColors.midBlack),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
