import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/strings.dart';

class NetworkListTile extends StatelessWidget {
  const NetworkListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ProjectColors.mainGray),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(profileImage),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            davidRay,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
