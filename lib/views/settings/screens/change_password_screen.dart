import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscure = false;
  bool _obscure1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
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
                  height: 40,
                ),
                textTile(enterCurrentPassword),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  // controller: nameController,
                  initialValue: helloTest,
                  textSize: 16,
                  obscure: true,
                  iconButton: null,
                  onTap: () {},
                ),
                const SizedBox(
                  height: 25,
                ),
                textTile(enterNewPassword),
                const SizedBox(
                  height: 5,
                ),
                ReusableTextField(
                  // controller: nameController,
                  initialValue: helloTest,
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
                  initialValue: helloTest,
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
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            size: 15,
                          ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        color: Colors.transparent,
        child: ButtonTile(text: save, boxRadius: 8),
      ),
    );
  }

  Widget textTile(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ProjectColors.midBlack.withOpacity(0.4),
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
                color: ProjectColors.mainPurple.withOpacity(0.1),
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
                    style: GoogleFonts.montserrat(
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
