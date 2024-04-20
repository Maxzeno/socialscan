import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TabTextTile extends StatelessWidget {
  final String iconPath;
  final String text;
  // final bool isSelected;
  const TabTextTile({
    super.key,
    required this.iconPath,
    required this.text,
    // required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: InkWell(
        // onTap: isSelected,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 18,
              width: 18,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
