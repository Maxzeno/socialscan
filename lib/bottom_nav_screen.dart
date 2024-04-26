import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/views/profile/screens/profile_screen.dart';

import 'views/home/screens/home_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  List pages = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7A60A5),
                  Color(0xFF101010),
                  // Color(0xFF82C3DF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [
                  0.0,
                  1.0,
                ],
                tileMode: TileMode.clamp,
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: ProjectColors.mainPurple,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                print('Index is : $index');
                if (mounted) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
              backgroundColor: const Color(0xFF000034),
              // activeColor: Colors.grey,
              // height: 55,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _currentIndex == 0 ? homeIconFill : homeIcon,
                    height: 24,
                    width: 24,
                    color: _currentIndex == 0
                        ? ProjectColors.mainPurple
                        : Colors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _currentIndex == 1 ? networkIconFill : networkIcon,
                      height: 24,
                      width: 24,
                      color: _currentIndex == 1
                          ? ProjectColors.mainPurple
                          : Colors.white,
                    ),
                    label: 'Profile'),
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
