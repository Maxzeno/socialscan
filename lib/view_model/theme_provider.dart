import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String themeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeModeString = sharedPreferences.getString(themeKey);
    if (themeModeString != null) {
      try {
        _themeMode = ThemeMode.values.byName(themeModeString);
      } catch (e) {
        print(
            "Invalid theme mode stored: $themeModeString. Defaulting to light theme.");
        _themeMode = ThemeMode.light;
      }
    }
    notifyListeners();
  }

  void toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(themeKey, _themeMode.name);
    notifyListeners();
  }

  static final darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF5b5d61),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF5b5d61).withOpacity(0.2),
    ),
    primaryColor: Colors.white,
    cardColor: const Color(0xFF3d3e40),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF002FFF),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
  );
}
