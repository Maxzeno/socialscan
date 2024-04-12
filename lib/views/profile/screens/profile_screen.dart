import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/views/settings/widgets/custom_country_picker.dart';

import '../../../utils/frosted_glass_box.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FrostedGlassBox(
                  title: davidRay,
                  subTitle: fullStack,
                  theChild: Stack(
                    children: [
                      CircleAvatar(
                        radius: 94,
                        backgroundImage: NetworkImage(
                          profileImage,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 30,
                        child: changeProfileIcon(),
                      ),
                    ],
                  ),
                  image: profileImage,
                ),
                const SizedBox(
                  height: 30,
                ),
                textTile(name),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  // controller: nameController,
                  initialValue: davidRay,
                  obscure: false,
                  iconButton: null,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 25,
                ),
                textTile(profession),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  // controller: nameController,
                  initialValue: fullStack,
                  obscure: false,
                  iconButton: null,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 25,
                ),
                textTile(phone),
                const SizedBox(
                  height: 5,
                ),
                const CustomCountryField(),
                const SizedBox(
                  height: 25,
                ),
                textTile(email),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  // controller: nameController,
                  initialValue: profileEmail,
                  obscure: false,
                  iconButton: null,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                // ButtonTile(text: save, boxRadius: 8),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        color: Colors.transparent,
        child: ButtonTile(text: save, boxRadius: 8),
      ),
    );
  }

  Widget changeProfileIcon() {
    return Container(
      height: 33,
      width: 33,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ProjectColors.mainPurple,
      ),
      child: Center(
          child: SvgPicture.asset(
        editIcon,
      )),
    );
  }

  Widget textTile(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.midBlack.withOpacity(0.4),
      ),
    );
  }
}
