// theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// theme.dart

// enum ThemeMode { light, dark }

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1A1621),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1621),
  ),
  primaryColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2E2537),
  ),
  fontFamily: 'Montserrat',
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xFF2E2537)),
  cardColor: const Color(0xFF3d3e40).withOpacity(0.1),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF002FFF),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  cardColor: const Color(0xFF3d3e40).withOpacity(0.1),
  fontFamily: 'Montserrat',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
);

enum ThemeModeEnum { light, dark }

class ThemeNotifier extends StateNotifier<ThemeModeEnum> {
  ThemeNotifier() : super(ThemeModeEnum.light);

  static const String themeKey = 'themeMode';

  Future<void> _loadTheme() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeModeString = sharedPreferences.getString(themeKey);
    if (themeModeString != null) {
      try {
        state = themeModeString == 'light'
            ? ThemeModeEnum.light
            : ThemeModeEnum.dark;
      } catch (e) {
        print(
            "Invalid theme mode stored: $themeModeString. Defaulting to light theme.");
        state = ThemeModeEnum.light;
      }
    }
  }

  Future<void> toggleTheme() async {
    state =
        state == ThemeModeEnum.light ? ThemeModeEnum.dark : ThemeModeEnum.light;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        themeKey, state == ThemeModeEnum.light ? 'light' : 'dark');
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeModeEnum>((ref) {
  final themeNotifier = ThemeNotifier();
  themeNotifier._loadTheme();
  return themeNotifier;
});
