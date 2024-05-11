import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/profile/screens/edit_profile_screen.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          settings,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: ProjectColors.midBlack,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              general,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GeneralOptions(
              context: context,
              userProvider: userProvider,
            ),
            const SizedBox(
              height: 35,
            ),
            // Text(
            //   whileConnecting,
            //   style: const TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            // whileConnectingOption(),
          ],
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

  // Widget generalOptions(UserProvider userProvider) {
  //   return ;
  // }
}

class GeneralOptions extends StatefulWidget {
  const GeneralOptions({
    super.key,
    required this.context,
    required this.userProvider,
  });

  final BuildContext context;
  final UserProvider userProvider;

  @override
  State<GeneralOptions> createState() => _GeneralOptionsState();
}

class _GeneralOptionsState extends State<GeneralOptions> {
  // bool _isChecked = false;
  // int _selectedCheckbox = 0;

  bool isCheckedDarkTheme = false;
  bool isCheckedLightTheme = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

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
            text: "Edit Profile",
            icon: SvgPicture.asset(
              forwardIcon,
              height: 24,
              width: 24,
            ),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const EditProfileScreen(),
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
            onTap: () {
              showModalBottomSheet(
                context: widget.context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                builder: (context) {
                  return SizedBox(
                    height: screenHeight * 0.18,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF7E7E7E),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox.adaptive(
                                      value: isCheckedLightTheme,
                                      activeColor: ProjectColors.mainPurple,
                                      checkColor: ProjectColors.mainPurple,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return const Color(0xFFE5E5E5);
                                        }
                                        return ProjectColors.mainPurple;
                                      }),
                                      side: const BorderSide(
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      onChanged: (value) {
                                          // _isChecked = value!;
                                          // _selectedCheckbox = value! ? 1 : 0;
                                          setState(() {
                                            isCheckedLightTheme = true;
                                            isCheckedDarkTheme = false;
                                            // isCheckedLightTheme = !isCheckedLightTheme;
                                            // if (isCheckedLightTheme) {
                                            //   isCheckedDarkTheme = false;
                                            // }
                                          });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: const Text(
                              "Light Theme",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListTile(
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF7E7E7E),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: Checkbox.adaptive(
                                      value: isCheckedDarkTheme,
                                      activeColor: ProjectColors.mainPurple,
                                      checkColor: ProjectColors.mainPurple,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return const Color(0xFFE5E5E5);
                                        }
                                        return ProjectColors.mainPurple;
                                      }),
                                      side: const BorderSide(
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      onChanged: (value) {
                                          // _selectedCheckbox = value! ? 2 : 0;
                                          setState(() {
                                            // isCheckedDarkTheme = value!;
                                            // // isCheckedDarkTheme = !isCheckedDarkTheme;
                                            // if (isCheckedDarkTheme) {
                                            //   isCheckedLightTheme = false;
                                            // }
                                            isCheckedDarkTheme = true;
                                            isCheckedLightTheme = false;
                                          });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: const Text(
                              "Dark Theme",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const Divider(
            thickness: 0.8,
          ),
          OptionTile(
            text: 'Log Out',
            icon: const Icon(
              Icons.exit_to_app,
              size: 20,
              color: Colors.red,
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Container(
                    // decoration: const BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(20),
                    //     topRight: Radius.circular(20),
                    //   ),
                    // ),
                    height: screenHeight * 0.48,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenHeight / 40,
                      vertical: screenHeight / 35,
                    ),
                    child: Column(
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text(
                              "?",
                              style: TextStyle(
                                fontSize: 66,
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              "Logout?",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Text(
                              "Are you sure you want to logout?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            SizedBox(
                              height: 54,
                              width: double.infinity,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      width: 1,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  widget.userProvider.signOut(context);
                                },
                                child: const Text(
                                  'Yes, Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            SizedBox(
                              height: 54,
                              width: double.infinity,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      width: 1,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No, Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
