import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final Widget icon;
  const OptionTile({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
