import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/auth/screens/sign_up_screen.dart';
import 'package:socialscan/views/home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      final authModelProvider =
          Provider.of<UserProvider>(context, listen: false);
      await authModelProvider.isLoggedIn();

      if (authModelProvider.isSignedIn) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const SignUpScreen(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BounceIn(
          preferences: const AnimationPreferences(
            duration: Duration(seconds: 2),
            autoPlay: AnimationPlayStates.Loop,
          ),
          child: Image.asset(
            'assets/images/sslogo_purple.png',
            height: 100,
          ),
        ),
      ),
    );
  }
}
