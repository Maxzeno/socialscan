import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';
import 'package:socialscan/views/settings/widgets/option_tile.dart';

import 'change_password_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isChecked = false;
  bool isChecked1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 40,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          // constraints: BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: ProjectColors.midBlack,
          ),
        ),
        title: Text(
          settings,
          style: GoogleFonts.montserrat(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: ProjectColors.midBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                general,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              generalOptions(),
              const SizedBox(
                height: 35,
              ),
              Text(
                whileConnecting,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              whileConnectingOption(),
            ],
          ),
        ),
      ),
    );
  }

  Container whileConnectingOption() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: ProjectColors.mainGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          OptionTile(
            text: sharePhoneNumber,
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: isChecked,
                activeColor: ProjectColors.mainPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (val) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
          const Divider(),
          OptionTile(
            text: shareEmail,
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: isChecked1,
                activeColor: ProjectColors.mainPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (val) {
                  setState(() {
                    isChecked1 = !isChecked1;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget generalOptions() {
    return Container(
      // height: 221,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: ProjectColors.mainGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OptionTile(
            text: profile,
            icon: SvgPicture.asset(
              forwardIcon,
              height: 24,
              width: 24,
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          const Divider(),
          OptionTile(
            text: changePassword,
            icon: SvgPicture.asset(
              forwardIcon,
              height: 24,
              width: 24,
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 0.8,
          ),
          OptionTile(
            text: theme,
            icon: SvgPicture.asset(
              forwardIcon,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
