import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/river_pod/theme_notifier.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/profile/screens/edit_profile_screen.dart';
import 'package:socialscan/views/settings/widgets/option_tile.dart';

import 'change_password_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          settings,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? ProjectColors.midBlack
                : ProjectColors.mainGray,
            // color: ProjectColors.midBlack,
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
}

class GeneralOptions extends ConsumerStatefulWidget {
  const GeneralOptions({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  ConsumerState<GeneralOptions> createState() => _GeneralOptionsState();
}

class _GeneralOptionsState extends ConsumerState<GeneralOptions> {
  bool? isGoogleAccount;

  bool isCheckedDarkTheme = false;
  bool isCheckedLightTheme = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);

    final themeNotifier = ref.read(themeProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);
    final userState = ref.watch(userProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // height: 221,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
              color: themeState == ThemeModeEnum.light
                  ? Colors.black
                  : Colors.white,
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
          if (!userState.isGoogleAccount) ...[
            const Divider(),
            OptionTile(
              text: changePassword,
              icon: SvgPicture.asset(
                forwardIcon,
                height: 24,
                width: 24,
                color: themeState == ThemeModeEnum.light
                    ? Colors.black
                    : Colors.white,
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
          ],
          const Divider(
            thickness: 0.8,
          ),
          OptionTile(
            text: theme,
            icon: SvgPicture.asset(
              forwardIcon,
              height: 24,
              width: 24,
              color: themeState == ThemeModeEnum.light
                  ? Colors.black
                  : Colors.white,
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
                            onTap: () {
                              setState(() {
                                isCheckedLightTheme = true;
                                isCheckedDarkTheme = false;
                                // isCheckedLightTheme = !isCheckedLightTheme;
                                // if (isCheckedLightTheme) {
                                //   isCheckedDarkTheme = false;
                                // }
                              });
                              themeNotifier.toggleTheme();
                              Navigator.pop(context);
                              print('Light');
                            },
                            leading: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).cardColor,
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
                                        return themeState == ThemeModeEnum.light
                                            ? ProjectColors
                                                .mainPurple // Fill color for selected light theme
                                            : Colors.transparent;
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
                                        // setState(() {
                                        //   isCheckedLightTheme = true;
                                        //   isCheckedDarkTheme = false;
                                        //   // isCheckedLightTheme = !isCheckedLightTheme;
                                        //   // if (isCheckedLightTheme) {
                                        //   //   isCheckedDarkTheme = false;
                                        //   // }
                                        // });
                                        // themeNotifier.toggleTheme();
                                        // Navigator.pop(context);
                                        // print('Light');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: const Text(
                              "Light Theme",
                              style: TextStyle(
                                // color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListTile(
                            onTap: () {
                              setState(() {
                                // isCheckedDarkTheme = value!;
                                // // isCheckedDarkTheme = !isCheckedDarkTheme;
                                // if (isCheckedDarkTheme) {
                                //   isCheckedLightTheme = false;
                                // }
                                isCheckedDarkTheme = true;
                                isCheckedLightTheme = false;
                              });
                              themeNotifier.toggleTheme();
                              Navigator.pop(context);

                              print('Dark');
                            },
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
                                        return themeState == ThemeModeEnum.light
                                            ? Colors
                                                .transparent // Transparent for light theme
                                            : ProjectColors.mainPurple;
                                      }),
                                      side: const BorderSide(
                                        color: Color(0xFFE5E5E5),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      onChanged: (value) {
                                        // _selectedCheckbox = value! ? 2 : 0;
                                        // setState(() {
                                        //   // isCheckedDarkTheme = value!;
                                        //   // // isCheckedDarkTheme = !isCheckedDarkTheme;
                                        //   // if (isCheckedDarkTheme) {
                                        //   //   isCheckedLightTheme = false;
                                        //   // }
                                        //   isCheckedDarkTheme = true;
                                        //   isCheckedLightTheme = false;
                                        // });
                                        // themeNotifier.toggleTheme();
                                        // Navigator.pop(context);

                                        // print('Dark');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: const Text(
                              "Dark Theme",
                              style: TextStyle(
                                // color: Colors.black,
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
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.grey.shade600
                                    : Colors.white60,
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
                                  userNotifier.signOut(context);
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
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.grey.shade600
                                          : Colors.white60,
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
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.grey.shade600
                                        : Colors.white60,
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
