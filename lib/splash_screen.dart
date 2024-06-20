import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialscan/bottom_nav_screen.dart';
import 'package:socialscan/utils/url.dart';
import 'package:socialscan/view_model/qr_url_nav.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/auth/screens/sign_in_screen.dart';

//
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      initDeepLinks();
      final userNotifier = ref.read(userProvider.notifier);
      await userNotifier.isLoggedIn();

      final isSignedIn = ref.read(userProvider).isSignedIn;
      if (isSignedIn) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const BottomNav(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const SignInScreen(),
          ),
        );
      }
    });
  }

  void initDeepLinks() {
    AppLinks appLinks = AppLinks();

    appLinks.uriLinkStream.listen((uri) {
      print('uri: $uri');
      if (uri.toString().contains(qrDomain)) {
        ref.read(qrUrlNavProvider.notifier).state = uri.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HeartBeat(
          preferences: const AnimationPreferences(
            duration: Duration(seconds: 2),
            autoPlay: AnimationPlayStates.Loop,
          ),
          child: Image.asset(
            'assets/images/socialscan_logo_png.png',
            height: 100,
          ),
        ),
      ),
    );
  }
}
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(const Duration(seconds: 3), () async {
//       final authModelProvider =
//           Provider.of<UserProvider>(context, listen: false);
//       await authModelProvider.isLoggedIn();
//
//       if (authModelProvider.isSignedIn) {
//         Navigator.pushReplacement(
//           context,
//           CupertinoPageRoute(
//             builder: (_) => const BottomNav(),
//           ),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           CupertinoPageRoute(
//             builder: (_) => const SignInScreen(),
//           ),
//         );
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: HeartBeat(
//           preferences: const AnimationPreferences(
//             duration: Duration(seconds: 2),
//             autoPlay: AnimationPlayStates.Loop,
//           ),
//           child: Image.asset(
//             'assets/images/sslogo_purple.png',
//             height: 100,
//           ),
//         ),
//       ),
//     );
//   }
// }
