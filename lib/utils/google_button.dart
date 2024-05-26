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
  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  Future googleLogin() async {
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomNav()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: CompleteAccountPreference().isAccountSetupComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while waiting for the check
        }

        bool isAccountSetupComplete = snapshot.data ?? false;

        return GestureDetector(
          onTap: () {
            if (isAccountSetupComplete) {
              googleLogin();
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteGoogleProfile()));
            }
          },
          child: Container(
            height: 53,
            width: 388,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: ProjectColors.midBlack.withOpacity(0.4),
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
      },
    );
  }
}
