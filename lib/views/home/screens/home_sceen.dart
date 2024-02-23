import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/network_list_tile.dart';
import 'package:socialscan/views/home/widgets/tab_text_tile.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
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
                  child: TabBarView(
                    children: [
                      const Center(
                        child: Text('Still Cooking...'),
                      ),
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
      height: 58,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 17,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: ProjectColors.mainGray.withOpacity(0.7),
        borderRadius: BorderRadius.circular(94),
      ),
      child: TabBar(
        labelColor: ProjectColors.mainPurple,
        unselectedLabelColor: Colors.black,
        splashBorderRadius: BorderRadius.circular(94),
        indicatorColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.symmetric(
          vertical: 3,
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

  Widget textTile(String text, bool visible) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Visibility(
          visible: visible,
          child: SvgPicture.asset(
            searchIcon,
            height: 21,
            width: 21,
          ),
        ),
      ],
    );
  }

  Widget dateNetwork() {
    return SingleChildScrollView(
      child: Column(
        children: [
          textTile(today, true),
          const SizedBox(
            height: 18,
          ),
          networkLists(3),
          const SizedBox(
            height: 25,
          ),
          textTile(yesterday, false),
          const SizedBox(
            height: 18,
          ),
          networkLists(4),
        ],
      ),
    );
  }
}
