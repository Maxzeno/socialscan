import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/screens/network_page.dart';
import 'package:socialscan/views/home/screens/socials_page.dart';
import 'package:socialscan/views/home/widgets/tabs_container_widget.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      //     style: TextStyle(
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
                    const Text(
                      // helloDavid,
                      "Hello David",
                      style: TextStyle(
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
                const TabsContainerWidget(),
                const SizedBox(
                  height: 25,
                ),
                const Expanded(
                  // height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    children: [
                      SocialsPage(),
                      NetworkPage(),
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
}
