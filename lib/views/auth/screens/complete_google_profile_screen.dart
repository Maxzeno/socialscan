import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialscan/utils/colors.dart';

import '../../../utils/button.dart';
import '../../../utils/strings.dart';
import '../../../utils/textfield.dart';
import '../../../view_model/river_pod/user_notifier.dart';
import '../../settings/widgets/custom_country_picker.dart';

class CompleteGoogleProfile extends ConsumerStatefulWidget {
  final String? email;
  const CompleteGoogleProfile({super.key, required this.email});

  @override
  ConsumerState<CompleteGoogleProfile> createState() =>
      _CompleteGoogleProfileState();
}

class _CompleteGoogleProfileState extends ConsumerState<CompleteGoogleProfile> {
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
                    const Text(
                      'Complete your profile',
                      style: TextStyle(
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
                    ReusableTextField(
                      initialValue: widget.email,
                      // textInputType: TextInputType.name,
                      // controller: userNotifier.professionController,
                      hintText: 'Profession',
                      obscure: false,
                      onTap: () {},
                      iconButton: null,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ReusableTextField(
                      textInputType: TextInputType.name,
                      controller: userNotifier.professionController,
                      hintText: 'Profession',
                      obscure: false,
                      onTap: () {},
                      iconButton: null,
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
                    const SizedBox(
                      height: 40,
                    ),
                    ButtonTile(
                      text: create,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            userState.countryCode != null) {
                          userNotifier
                              .registerWithGoogle(context)
                              .then((user) => print('Hello'))
                              .catchError((e) => print('error== > $e'));
                        }
                      },
                      boxRadius: 8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
