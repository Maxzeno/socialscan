import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/network_list_tile.dart';
import 'package:socialscan/views/home/widgets/social_media_tile.dart';
import 'package:socialscan/views/home/widgets/tab_text_tile.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

import '../../../utils/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   // leadingWidth: 20,
      //   elevation: 0.0,
      //   leading: Center(
      //     child: CircleAvatar(
      //       radius: 20,
      //       backgroundImage: NetworkImage(profileImage),
      //     ),
      //   ),
      //   title: Text(
      //     helloDavid,
      //     style: GoogleFonts.montserrat(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //       color: ProjectColors.midBlack,
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: SvgPicture.asset(
      //         settingsIcon,
      //         height: 24,
      //         width: 24,
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(profileImage),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      helloDavid,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ProjectColors.midBlack,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const SettingScreen(),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        settingsIcon,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                tabs(),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  // height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      socials(),
                      dateNetwork(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container tabs() {
    return Container(
      height: 63,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 17,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: ProjectColors.tabBgColor,
        borderRadius: BorderRadius.circular(94),
      ),
      child: TabBar(
        labelColor: ProjectColors.mainPurple,
        unselectedLabelColor: Colors.black,
        splashBorderRadius: BorderRadius.circular(94),
        indicatorColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(94),
          // border: Border.all(color: darkGrey),
        ),
        tabs: [
          TabTextTile(
              iconPath: _selectedIndex == 0 ? homeIconFill : homeIcon,
              text: home,
              isSelected: _selectedIndex == 0),
          TabTextTile(
              iconPath: _selectedIndex == 1 ? networkIconFill : networkIcon,
              text: network,
              isSelected: _selectedIndex == 1),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }

  Widget socials() {
    return SingleChildScrollView(
      child: Column(
        children: [
          textTile(
            text: mySocials,
            size: 16,
            icon: SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: isChecked,
                activeColor: ProjectColors.mainPurple,
                side: const BorderSide(width: 1),
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
          const SizedBox(
            height: 14,
          ),
          socialLists(),
          const SizedBox(
            height: 55,
          ),
          ButtonTile(text: save, boxRadius: 8),
        ],
      ),
    );
  }

  Widget socialLists() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 2.3 / 2.1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      shrinkWrap: true,
      itemCount: socialLinks.length + 1,
      itemBuilder: (context, index) {
        if (index == socialLinks.length) {
          return DottedBorder(
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
                      height: 18,
                      width: 18,
                      color: ProjectColors.midBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    addNew,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ProjectColors.midBlack.withOpacity(0.5),
                    ),
                  ),
                ],
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

  Widget networkLists(int? count) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count ?? 3,
      itemBuilder: (context, index) => const NetworkListTile(),
      separatorBuilder: (context, child) => const SizedBox(
        height: 10,
      ),
    );
  }

  Widget textTile({String? text, Widget? icon, double? size}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text!,
          style: GoogleFonts.montserrat(
            fontSize: size ?? 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon!,
      ],
    );
  }

  Widget dateNetwork() {
    return SingleChildScrollView(
      child: Column(
        children: [
          textTile(
            text: today,
            icon: SvgPicture.asset(
              searchIcon,
              height: 21,
              width: 21,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          networkLists(3),
          const SizedBox(
            height: 25,
          ),
          textTile(text: yesterday, icon: const SizedBox()),
          const SizedBox(
            height: 18,
          ),
          networkLists(4),
        ],
      ),
    );
  }
}
