import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class ButtonTile extends StatelessWidget {
  final String text;
  final double boxRadius;
  final double? width;

  const ButtonTile(
      {super.key, required this.text, required this.boxRadius, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      width: width ?? 388,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(boxRadius),
        color: ProjectColors.mainPurple,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
