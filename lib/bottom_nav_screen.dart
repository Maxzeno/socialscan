import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/user_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/qr_url_nav.dart';
import 'package:socialscan/views/home/screens/home_screen.dart';
import 'package:socialscan/views/home/screens/network_page.dart';
import 'package:socialscan/views/home/screens/preview_scan_link_screen.dart';
import 'package:socialscan/views/settings/screens/settings_screen.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  int _currentIndex = 0;
  List pages = [
    const HomeScreen(),
    const NetworkPage(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    navQrPreview();
    super.initState();
  }

  navQrPreview() {
    final qrUrlNavProviderProvider = ref.watch(qrUrlNavProvider);
    print('qrUrlNavProviderProvider: $qrUrlNavProviderProvider');

    if (qrUrlNavProviderProvider.isNotEmpty) {
      UserModel user = parseQRData(qrUrlNavProviderProvider);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PreviewScanLinkScreen(
            data: [user],
          ),
        ),
      );
      ref.invalidate(qrUrlNavProvider);
    }
  }

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
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : ProjectColors.navBarBlack,
              selectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? ProjectColors.mainPurple
                      : ProjectColors.lightishPurple,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.light
                      ? ProjectColors.bgBlack
                      : Colors.white.withOpacity(0.6),
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
                  // backgroundColor: Theme.of(context).brightness == Brightness.dark && _currentIndex == 0 ? ProjectColors.lightishPurple : null,
                  backgroundColor: ProjectColors.lightishPurple,
                  icon: SvgPicture.asset(
                    _currentIndex == 0 ? homeIconFill : homeIcon,
                    height: 20,
                    width: 20,

                    // color: _currentIndex == 0
                    //     ? ProjectColors.mainPurple
                    //     : ProjectColors.midBlack,

                    // colorFilter: ColorFilter.mode(
                    //   _currentIndex == 0
                    //     ? (Theme.of(context).brightness == Brightness.light ? ProjectColors.mainPurple : null)
                    //     : Theme.of(context).brightness == Brightness.light
                    //         ? ProjectColors.midBlack
                    //         : Colors.white,
                    //   BlendMode.srcIn,
                    // ),
                    colorFilter:
                        Theme.of(context).brightness == Brightness.light
                            ? null
                            : ColorFilter.mode(
                                Theme.of(context).brightness == Brightness.light
                                    ? ProjectColors.bgBlack
                                    : _currentIndex == 0
                                        ? ProjectColors.lightishPurple
                                        : Colors.white.withOpacity(0.6),
                                BlendMode.srcIn,
                              ),

                    // colorFilter: ColorFilter.mode(
                    //  Theme.of(context).brightness == Brightness.light
                    //         ? ProjectColors.midBlack
                    //         : Colors.white.withOpacity(0.6),
                    //   BlendMode.srcIn,
                    // ),

                    // color: _currentIndex == 0
                    //     ? ProjectColors.mainPurple
                    //     : Theme.of(context).brightness == Brightness.light
                    //         ? ProjectColors.midBlack
                    //         : Colors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark &&
                              _currentIndex == 1
                          ? ProjectColors.lightishPurple
                          : null,
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
                    colorFilter: ColorFilter.mode(
                      _currentIndex == 1
                          ? Theme.of(context).brightness == Brightness.light
                              ? ProjectColors.mainPurple
                              : ProjectColors.lightishPurple
                          : Theme.of(context).brightness == Brightness.light
                              ? ProjectColors.bgBlack
                              : Colors.white.withOpacity(0.6),
                      // : ProjectColors.lightishPurple.withOpacity(0.7),
                      BlendMode.srcIn,
                    ),
                    // color: _currentIndex == 1
                    //     ? ProjectColors.mainPurple
                    //     : Theme.of(context).brightness == Brightness.light
                    //         ? ProjectColors.midBlack
                    //         : Colors.white,
                  ),
                  label: 'Network',
                ),
                BottomNavigationBarItem(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark &&
                              _currentIndex == 2
                          ? ProjectColors.lightishPurple
                          : null,
                  icon: SvgPicture.asset(
                    _currentIndex == 2 ? fillSettingsIcon : settingsIcon,

                    height: 20,
                    width: 20,
                    // color: Theme.of(context).brightness == Brightness.light &&
                    //         _currentIndex == 1
                    //     ? Colors.black
                    //     : Colors.white
                    colorFilter: ColorFilter.mode(
                      _currentIndex == 2
                          ? Theme.of(context).brightness == Brightness.light
                              ? ProjectColors.mainPurple
                              : ProjectColors.lightishPurple
                          : Theme.of(context).brightness == Brightness.light
                              ? ProjectColors.bgBlack
                              : Colors.white.withOpacity(0.5),
                      BlendMode.srcIn,
                    ),
                    // color: _currentIndex == 2
                    //     ? ProjectColors.mainPurple
                    //     : Theme.of(context).brightness == Brightness.light ? ProjectColors.midBlack : Colors.white,
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
