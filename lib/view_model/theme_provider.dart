import 'package:flutter/material.dart';

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
    scaffoldBackgroundColor: const Color(0xFF5b5d61),
    // scaffoldBackgroundColor: const Color(0xff3450A1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF5b5d61).withOpacity(0.2),
    ),
    // appBarTheme: const AppBarTheme(backgroundColor: Color(0xff3450A1)),
    primaryColor: Colors.white,
    // cardColor: const Color(0xff0A155A),
    cardColor: const Color(0xFF3d3e40),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    // scaffoldBackgroundColor: const Color(0xFF3d3e40),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFF002FFF)),
    // appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF3d3e40)),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  );
}
