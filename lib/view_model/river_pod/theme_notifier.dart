import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialscan/utils/colors.dart';

final darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ProjectColors.bgBlack,
  appBarTheme: const AppBarTheme(
    backgroundColor: ProjectColors.bgBlack,
  ),
  primaryColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2E2537),
  ),
  fontFamily: 'Montserrat',
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: ProjectColors.cardBlackColor),
  cardColor: ProjectColors.cardBlackColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ProjectColors.mainPurple,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ProjectColors.mainPurple,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  cardColor: ProjectColors.mainGray,
  fontFamily: 'Montserrat',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
);

enum ThemeModeEnum { system, light, dark }

class ThemeNotifier extends StateNotifier<ThemeModeEnum> {
  ThemeNotifier() : super(ThemeModeEnum.system);

  static const String themeKey = 'themeMode';

  Future<void> _loadTheme() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeModeString = sharedPreferences.getString(themeKey);
    if (themeModeString != null) {
      try {
        state = ThemeModeEnum.values.byName(themeModeString);
      } catch (e) {
        print(
            "Invalid theme mode stored: $themeModeString. Defaulting to system theme.");
        state = ThemeModeEnum.system;
      }
    }
  }

  Future<void> toggleTheme(ThemeModeEnum newMode) async {
    state = newMode;
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(themeKey, newMode.name);
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeModeEnum>((ref) {
  final themeNotifier = ThemeNotifier();
  themeNotifier._loadTheme();
  return themeNotifier;
});

// enum ThemeModeEnum { light, dark, system }
//
// class ThemeNotifier extends StateNotifier<ThemeModeEnum> {
//   ThemeNotifier() : super(ThemeModeEnum.system);
//
//   static const String themeKey = 'themeMode';
//
//   Future<void> _loadTheme() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final themeModeString = sharedPreferences.getString(themeKey);
//     if (themeModeString != null) {
//       try {
//         state = ThemeModeEnum.values.firstWhere(
//           (mode) => mode.toString() == 'ThemeModeEnum.$themeModeString',
//           orElse: () => ThemeModeEnum.system,
//         );
//       } catch (e) {
//         print(
//             "Invalid theme mode stored: $themeModeString. Defaulting to system theme.");
//         state = ThemeModeEnum.system;
//       }
//     }
//   }
//
//   Future<void> toggleTheme() async {
//     if (state == ThemeModeEnum.system) {
//       state = ThemeModeEnum.light;
//     } else {
//       state = state == ThemeModeEnum.light
//           ? ThemeModeEnum.dark
//           : ThemeModeEnum.light;
//     }
//     final sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString(themeKey, state.toString().split('.').last);
//   }
//
//   Future<void> toggleUseSystemTheme() async {
//     state = ThemeModeEnum.system;
//     final sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString(themeKey, state.toString().split('.').last);
//   }
//
//   ThemeMode getThemeMode() {
//     switch (state) {
//       case ThemeModeEnum.light:
//         return ThemeMode.light;
//       case ThemeModeEnum.dark:
//         return ThemeMode.dark;
//       case ThemeModeEnum.system:
//       default:
//         return ThemeMode.system;
//     }
//   }
// }
//
// final themeProvider =
//     StateNotifierProvider<ThemeNotifier, ThemeModeEnum>((ref) {
//   final themeNotifier = ThemeNotifier();
//   themeNotifier._loadTheme();
//   return themeNotifier;
// });

// // theme.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socialscan/utils/colors.dart';
// // theme.dart
//
// // enum ThemeMode { light, dark }
//
// final darkTheme = ThemeData(
//   useMaterial3: false,
//   // primaryColorDark: ProjectColors.mainPurple,
//   // colorScheme: ColorScheme.fromSeed(seedColor: ProjectColors.mainPurple),
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: ProjectColors.bgBlack,
//   appBarTheme: const AppBarTheme(
//     backgroundColor: ProjectColors.bgBlack,
//   ),
//   primaryColor: Colors.white,
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     backgroundColor: Color(0xFF2E2537),
//   ),
//   fontFamily: 'Montserrat',
//   // bottomSheetTheme:
//   //     const BottomSheetThemeData(backgroundColor: Color(0xFF2E2537)),
//   bottomSheetTheme:
//       const BottomSheetThemeData(backgroundColor: ProjectColors.cardBlackColor),
//   cardColor: ProjectColors.cardBlackColor,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: ProjectColors.mainPurple,
//   ),
// );
//
// final lightTheme = ThemeData(
//   useMaterial3: false,
//   // primaryColorLight: ProjectColors.mainPurple,
//   // colorScheme: ColorScheme.fromSeed(seedColor: ProjectColors.mainPurple),
//   brightness: Brightness.light,
//   scaffoldBackgroundColor: Colors.white,
//   primaryColor: Colors.black,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//     backgroundColor: ProjectColors.mainPurple,
//   ),
//   iconTheme: const IconThemeData(color: Colors.black),
//   bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
//   // cardColor: const Color(0xFF3d3e40).withOpacity(0.1),
//   cardColor: ProjectColors.mainGray,
//   fontFamily: 'Montserrat',
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Colors.white,
//   ),
// );
//
// enum ThemeModeEnum { light, dark }
//
// class ThemeNotifier extends StateNotifier<ThemeModeEnum> {
//   ThemeNotifier() : super(ThemeModeEnum.light);
//
//   static const String themeKey = 'themeMode';
//
//   Future<void> _loadTheme() async {
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final themeModeString = sharedPreferences.getString(themeKey);
//     if (themeModeString != null) {
//       try {
//         state = themeModeString == 'light'
//             ? ThemeModeEnum.light
//             : ThemeModeEnum.dark;
//       } catch (e) {
//         print(
//             "Invalid theme mode stored: $themeModeString. Defaulting to light theme.");
//         state = ThemeModeEnum.light;
//       }
//     }
//   }
//
//   Future<void> toggleTheme() async {
//     state =
//         state == ThemeModeEnum.light ? ThemeModeEnum.dark : ThemeModeEnum.light;
//     final sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString(
//         themeKey, state == ThemeModeEnum.light ? 'light' : 'dark');
//   }
// }
//
// final themeProvider =
//     StateNotifierProvider<ThemeNotifier, ThemeModeEnum>((ref) {
//   final themeNotifier = ThemeNotifier();
//   themeNotifier._loadTheme();
//   return themeNotifier;
// });
