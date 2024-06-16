import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  Future<void> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent!');

      VxToast.show(
        context,
        msg: 'Password reset email sent!',
        bgColor: ProjectColors.successColor.withOpacity(0.95),
        textColor: Colors.white,
        showTime: 5000,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for the provided email.');
        VxToast.show(
          context,
          msg: 'No user found for the provided email.',
          bgColor: ProjectColors.errorColor.withOpacity(0.95),
          textColor: Colors.white,
          showTime: 4000,
        );
      } else {
        print('Error sending password reset email: ${e.code}');
        VxToast.show(
          context,
          msg: 'Error. Please try again.',
          bgColor: ProjectColors.errorColor.withOpacity(0.95),
          textColor: Colors.white,
          showTime: 4000,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 70,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            // color: Colors.black,
          ),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your password:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ReusableTextField(
              controller: _emailController,
              hintText: 'Email',
              obscure: false,
              onTap: () {},
              iconButton: const SizedBox(),
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 18,
            ),
            ButtonTile(
              text: "Send Password Reset Email",
              // loading: userState.isLoading,
              onTap: () {
                // userNotifier.signIn(context);
                sendPasswordResetEmail(_emailController.text);
              },
              boxRadius: 8,
            ),
            // const SizedBox(
            //   height: 18,
            // ),
            // Row(
            //   children: [
            //     const Text(
            //       "Go back and",
            //       style: TextStyle(
            //         fontSize: 14,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const SignInScreen(),
            //           ),
            //         );
            //       },
            //       child: Text(
            //         "Login",
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           color: Theme.of(context).brightness == Brightness.light
            //               ? ProjectColors.mainPurple.withOpacity(0.6)
            //               : Colors.purple.shade300,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          
          ],
        ),
      ),
    );
  }
}
