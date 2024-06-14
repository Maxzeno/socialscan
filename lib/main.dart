import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialscan/splash_screen.dart';
import 'package:socialscan/view_model/dependency_injection/dependency_injection.dart';
import 'package:socialscan/view_model/river_pod/network_connectivity_notifier.dart';
import 'package:socialscan/view_model/river_pod/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: MyApp()));
  DependencyInjection.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    ref.listen<ConnectivityStatus>(connectivityProvider,
        (previousState, newState) {
      switch (newState) {
        case ConnectivityStatus.WiFi:
          Fluttertoast.showToast(
            msg: 'WiFi connected',
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
          break;
        case ConnectivityStatus.Cellular:
          // Handle cellular connection
          break;
        case ConnectivityStatus.Offline:
          Fluttertoast.showToast(
            msg: 'No internet connection',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
          );
          break;
      }
    });
    ThemeMode getThemeMode(ThemeModeEnum themeModeEnum) {
      switch (themeModeEnum) {
        case ThemeModeEnum.light:
          return ThemeMode.light;
        case ThemeModeEnum.dark:
          return ThemeMode.dark;
        case ThemeModeEnum.system:
        default:
          return ThemeMode.system;
      }
    }

    return MaterialApp(
      title: 'Social Scan',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // Use light theme
      darkTheme: darkTheme,
      // Use dark theme
      themeMode: getThemeMode(themeState),
      home: const SplashScreen(),
    );
  }

  // return MultiProvider(
  //   providers: [
  //     ChangeNotifierProvider(
  //       create: (_) => UserProvider(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (_) => NumberProvider(),
  //     ),
  //     ChangeNotifierProvider(
  //       create: (_) => ThemeProvider(),
  //     ),
  //   ],
  //   child: Consumer<ThemeProvider>(builder: (context, themeViewModel, _) {
  //     return MaterialApp(
  //       title: 'Social Scan',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeProvider.lightTheme,
  //       darkTheme: ThemeProvider.darkTheme,
  //       themeMode: themeViewModel.themeMode,
  //       // home: const HomeScreen(),
  //       home: const SplashScreen(),
  //     );
  //   }),
  // );
}
