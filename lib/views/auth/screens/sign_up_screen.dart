import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/view_model/user_provider.dart';
import 'package:socialscan/views/auth/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: true,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Form(
            key: _formKey,
            child: ListView(
              // clipBehavior: Clip.none,

              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  createAnAccount,
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.name,
                        controller: userProvider.firstName,
                        hintText: 'First Name',
                        obscure: false,
                        onTap: () {},
                        iconButton: null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.name,
                        controller: userProvider.lastName,
                        hintText: 'Last Name',
                        obscure: false,
                        onTap: () {},
                        iconButton: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.emailAddress,
                        controller: userProvider.emailController,
                        hintText: 'Email',
                        obscure: false,
                        onTap: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        iconButton: null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.number,
                        controller: userProvider.phoneNumber,
                        hintText: 'Phone number',
                        obscure: false,
                        onTap: () {},
                        iconButton: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                ReusableTextField(
                  textInputType: TextInputType.name,
                  controller: userProvider.bio,
                  hintText: 'Profession',
                  obscure: false,
                  onTap: () {},
                  iconButton: null,
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.visiblePassword,
                        controller: userProvider.passwordController,
                        hintText: 'Password',
                        obscure: _obscure,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ReusableTextField(
                        textInputType: TextInputType.visiblePassword,
                        controller: userProvider.retypePasswordController,
                        hintText: reTypePassword,
                        obscure: _obscureText,
                        iconButton: InkWell(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: _obscureText
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  size: 15,
                                )
                              : const Icon(
                                  Icons.visibility_outlined,
                                  size: 15,
                                ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please retype your password';
                          }
                          if (value != userProvider.passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ButtonTile(
                  text: create,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      userProvider.registerAccount(context);
                      print('Registration successful!');
                    }
                  },
                  boxRadius: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      alreadyHaveAnAccount,
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
                          CupertinoPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        login,
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
