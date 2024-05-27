import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/views/home/screens/home_screen.dart';
import 'package:socialscan/views/home/screens/network_page.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  List pages = [
    const HomeScreen(),
    const NetworkPage(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: WillPopScope(
        onWillPop: () async {
          if (_currentIndex > 0) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              // gradient: const LinearGradient(
              //   colors: [
              //     Color(0xFF7A60A5),
              //     Color(0xFF101010),
              //     // Color(0xFF82C3DF),
              //   ],
              //   begin: FractionalOffset(0.0, 0.0),
              //   end: FractionalOffset(1.0, 0.0),
              //   stops: [
              //     0.0,
              //     1.0,
              //   ],
              //   tileMode: TileMode.clamp,
              // ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: ProjectColors.mainPurple,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? ProjectColors.midBlack
                      : Colors.white,
              onTap: (index) async {
                print('Index is : $index');
                // final connectivityResult =
                //     await Connectivity().checkConnectivity();
                // if (connectivityResult == ConnectivityResult.wifi) {
                //   infoSnackBar(context, 'No internet connection',
                //       Duration(milliseconds: 200), Colors.red);
                // }
                setState(() {
                  _currentIndex = index;
                });
              },
              // backgroundColor: ProjectColors.mainGray,
              // activeColor: Colors.grey,
              // height: 55,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _currentIndex == 0 ? homeIconFill : homeIcon,
                    height: 20,
                    width: 20,

                    // color: _currentIndex == 0
                    //     ? ProjectColors.mainPurple
                    //     : ProjectColors.midBlack,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _currentIndex == 1
                        ? networkIconFill
                        : Theme.of(context).brightness == Brightness.light
                            ? networkIcon
                            : wProfileIcon,
                    height: 20,
                    width: 20,
                    // color: _currentIndex == 0
                    //     ? ProjectColors.mainPurple
                    //     : ProjectColors.midBlack,
                  ),
                  label: 'Network',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    // _currentIndex == 1 ? networkIconFill : networkIcon,
                    settingsIcon,
                    height: 20,
                    width: 20,
                    // color: Theme.of(context).brightness == Brightness.light &&
                    //         _currentIndex == 1
                    //     ? Colors.black
                    //     : Colors.white
                    // color: _currentIndex == 2
                    //     ? ProjectColors.mainPurple
                    //     : ProjectColors.midBlack,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: pages[_currentIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
