import 'package:flutter/material.dart';
import 'package:socialscan/utils/colors.dart';

enum Theme { dark, light }

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode =>
      _themeMode == ThemeMode.light ? ThemeMode.light : ThemeMode.dark;
  void toggleTheme() {
    print(themeMode.toString());

    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    print(themeMode.toString());
  }

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ProjectColors.bgBlack,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ProjectColors.midBlack,
    ),
    // scaffoldBackgroundColor: const Color(0xff3450A1),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF5b5d61).withOpacity(0.2),
    ),
    // appBarTheme: const AppBarTheme(backgroundColor: Color(0xff3450A1)),
    primaryColor: Colors.white,
    // cardColor: const Color(0xff0A155A),
    fontFamily: 'Montserrat',
    cardColor: const Color(0xFF3d3e40),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    // scaffoldBackgroundColor: const Color(0xFF3d3e40),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    primaryColor: Colors.black,
    fontFamily: 'Montserrat',
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFF002FFF)),
    // appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF3d3e40)),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );
}
