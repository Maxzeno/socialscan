import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/views/auth/screens/sign_up_screen.dart';

import '../../../utils/colors.dart';
import '../../../view_model/user_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                helloWelcomeBack,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ReusableTextField(
                controller: userProvider.emailController,
                hintText: 'Email',
                obscure: false,
                onTap: () {},
                iconButton: const SizedBox(),
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 18,
              ),
              ReusableTextField(
                controller: userProvider.passwordController,
                hintText: 'Password',
                obscure: _obscure,
                textInputType: TextInputType.visiblePassword,
                iconButton: InkWell(
                  onTap: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  child: _obscure
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          size: 15,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          size: 15,
                        ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                forgotPassword,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: ProjectColors.mainPurple.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonTile(
                text: login,
                loading: userProvider.isLoading,
                onTap: () {
                  userProvider.signIn(context);
                },
                boxRadius: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    dontHaveAnAccount,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text(
                      signUp,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: ProjectColors.mainPurple.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 108,
                    child: Divider(
                      color: ProjectColors.midBlack.withOpacity(0.4),
                    ),
                  ),
                  Text(orContinueWith),
                  SizedBox(
                    width: 108,
                    child: Divider(
                      color: ProjectColors.midBlack.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              accountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountButton() {
    return Container(
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
          const SizedBox(
            width: 16,
          ),
          Text(
            google,
            style: GoogleFonts.inter(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
