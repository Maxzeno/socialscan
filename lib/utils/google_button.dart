import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialscan/utils/shared_prefrences.dart';
import 'package:socialscan/utils/strings.dart';

import '../bottom_nav_screen.dart';
import '../views/auth/screens/complete_google_profile_screen.dart';
import 'colors.dart';
import 'images.dart';

class AccountButton extends StatefulWidget {
  const AccountButton({super.key});

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  Future googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return 'No User';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      bool isAccountSetupComplete =
          await CompleteAccountPreference().isAccountSetupComplete();

      if (isAccountSetupComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CompleteGoogleProfile(),
          ),
        );
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await googleLogin();
        // if (isAccountSetupComplete) {
        //   await googleLogin();
        // } else {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const CompleteGoogleProfile()));
        // }
      },
      child: Container(
        height: 53,
        width: 388,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.light
                ? ProjectColors.midBlack.withOpacity(0.4)
                : ProjectColors.mainGray,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(googleIcon),
            const SizedBox(width: 16),
            Text(
              google,
              style: GoogleFonts.inter(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
    // return FutureBuilder<bool>(
    //   future: CompleteAccountPreference().isAccountSetupComplete(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator();
    //     }
    //
    //     bool isAccountSetupComplete = snapshot.data ?? false;
    //
    //     return GestureDetector(
    //       onTap: () async {
    //         await googleLogin();
    //         // if (isAccountSetupComplete) {
    //         //   await googleLogin();
    //         // } else {
    //         //   Navigator.push(
    //         //       context,
    //         //       MaterialPageRoute(
    //         //           builder: (context) => const CompleteGoogleProfile()));
    //         // }
    //       },
    //       child: Container(
    //         height: 53,
    //         width: 388,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(8),
    //           border: Border.all(
    //             color: ProjectColors.midBlack.withOpacity(0.4),
    //             width: 0.5,
    //           ),
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Image.asset(googleIcon),
    //             const SizedBox(width: 16),
    //             Text(
    //               google,
    //               style: GoogleFonts.inter(
    //                 fontSize: 14,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
