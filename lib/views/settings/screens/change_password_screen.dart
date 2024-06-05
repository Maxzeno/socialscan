import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';

import '../../../utils/info_snackbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscure = false;
  bool _obscure1 = false;
  bool _obscure2 = false;
  final _formKey = GlobalKey<FormState>();

  final _enterPasswordController = TextEditingController();
  final _enterNewPasswordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
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
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackgroundBox(
                    theChild: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ProjectColors.mainPurple.withOpacity(0.4),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          lockIcon,
                          height: 37,
                          width: 37,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  textTile(enterCurrentPassword),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    // initialValue: helloTest,
                    controller: _enterPasswordController,
                    textSize: 16,
                    obscure: _obscure2,
                    iconButton: InkWell(
                      onTap: () {
                        setState(() {
                          _obscure2 = !_obscure2;
                        });
                      },
                      child: _obscure2
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
                    onTap: () {},
                    // onSaved: (value) {
                    //   _enterPassword = value!;
                    //   print('Enter password =====> $_enterPassword');
                    // },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textTile('Enter new password'),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    // initialValue: helloTest,
                    controller: _enterNewPasswordController,

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
                    // onSaved: (value) {
                    //   print('onSaved callback called!');
                    //   _enterNewPassword = value!;
                    //   print(
                    //       'enterNewPassword: $enterNewPassword'); // Check the value of enterNewPassword
                    // },
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  textTile(reEnterPassword),
                  const SizedBox(
                    height: 5,
                  ),
                  ReusableTextField(
                    // controller: nameController,
                    // initialValue: helloTest,
                    controller: _retypePasswordController,

                    obscure: _obscure1,
                    iconButton: InkWell(
                      onTap: () {
                        setState(() {
                          _obscure1 = !_obscure1;
                        });
                      },
                      child: _obscure1
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
                      // print(
                      //     'enterNewPassword: $_enterNewPassword'); // Check the value of enterNewPassword
                      // print('retypePassword: $_retypePassword');
                      if (value == null || value.isEmpty) {
                        return 'Please retype your password';
                      }
                      if (value != _enterNewPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    // onSaved: (value) {
                    //   _retypePassword = value!;
                    // },

                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            FirebaseService()
                .updatePassword(
                  currentPassword: _enterPasswordController.text,
                  newPassword: _enterNewPasswordController.text,
                )
                .then(
                  (value) => infoSnackBar(
                      context,
                      'Password Updated Successful',
                      const Duration(milliseconds: 400),
                      Colors.green),
                );
            _enterPasswordController.clear();
            _enterNewPasswordController.clear();
            _retypePasswordController.clear();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          color: Colors.transparent,
          child: ButtonTile(text: save, boxRadius: 8),
        ),
      ),
    );
  }

  Widget textTile(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        // color: ProjectColors.midBlack.withOpacity(0.4),
        color: Theme.of(context).brightness == Brightness.light
            ? ProjectColors.midBlack.withOpacity(0.4)
            : Colors.white,
      ),
    );
  }
}

class BackgroundBox extends StatelessWidget {
  const BackgroundBox({
    Key? key,
    required this.theChild,
  }) : super(key: key);

  final Widget theChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 252,
        width: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            // Blur effect (BackdropFilter)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? ProjectColors.mainPurple.withOpacity(0.1)
                    : ProjectColors.mainPurple.withOpacity(0.2),
              ),
            ),
            // Gradient effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.13),
                ),
              ),
            ),
            // Child widget
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  theChild,
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    changePassword,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
