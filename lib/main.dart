import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/splash_screen.dart';
import 'package:socialscan/view_model/number_provider.dart';
import 'package:socialscan/view_model/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NumberProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Social Scan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          // textTheme: TextStyleTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          fontFamily: 'Montserrat',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7F1F9A)),
          useMaterial3: false,
        ),
        // home: const HomeScreen(),
        home: const SplashScreen(),
      ),
    );
  }
}
