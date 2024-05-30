import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/auth/screens/sign_in_screen.dart';
import 'package:socialscan/views/settings/widgets/custom_country_picker.dart';

import '../../../utils/google_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.watch(userProvider.notifier);
    final userState = ref.watch(userProvider);
    // final notifier = ref.read(userProvider.notifier);
    return Scaffold(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      createAnAccount,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ReusableTextField(
                            textInputType: TextInputType.name,
                            controller: userNotifier.firstNameController,
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
                            controller: userNotifier.lastNameController,
                            hintText: 'Last Name',
                            obscure: false,
                            onTap: () {},
                            iconButton: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ReusableTextField(
                            textInputType: TextInputType.emailAddress,
                            controller: userNotifier.emailController,
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
                            textInputType: TextInputType.name,
                            controller: userNotifier.professionController,
                            hintText: 'Profession',
                            obscure: false,
                            onTap: () {},
                            iconButton: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomCountryField(
                      controller: userNotifier.phoneNumberController,
                      countryCode: userState.countryCode,
                      onTap: () {
                        userNotifier.selectCountryCode(context);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        ReusableTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller: userNotifier.passwordController,
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
                                    color: ProjectColors.mainPurple,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 15,
                                    color: ProjectColors.mainPurple,
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
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        ReusableTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller: userNotifier.retypePasswordController,
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
                                    color: ProjectColors.mainPurple,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    size: 15,
                                    color: ProjectColors.mainPurple,
                                  ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please retype your password';
                            }
                            if (value != userNotifier.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ButtonTile(
                      text: create,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            userState.countryCode != null) {
                          userNotifier.registerAccount(context);
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
                          style: const TextStyle(
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? ProjectColors.mainPurple.withOpacity(0.6)
                                  : ProjectColors.lightishPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // const Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          // width: double.infinity,
                          child: Divider(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? ProjectColors.midBlack.withOpacity(0.4)
                                    : ProjectColors.mainGray,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(orContinueWith),
                        const SizedBox(width: 12),
                        Expanded(
                          // width: double.infinity,
                          child: Divider(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? ProjectColors.midBlack.withOpacity(0.4)
                                    : ProjectColors.mainGray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AccountButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
