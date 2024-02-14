import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final dynamic validator;
  final bool? obscure;
  final Widget? iconButton;
  final VoidCallback onTap;
  final dynamic controller;
  const ReusableTextField(
      {Key? key,
      required this.hintText,
      this.controller,
      required this.onTap,
      this.validator,
      this.obscure,
      this.iconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final keyBoardProvider = Provider.of<KeyboardProvider>(context);
    return SizedBox(
      width: 388,
      height: 53,
      child: TextFormField(
        onTap: onTap,
        validator: validator,
        obscureText: obscure!,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        keyboardType: TextInputType.visiblePassword,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          // labelText: 'i3dn3kdnk3dn',
          suffixIcon: iconButton!,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),

          labelStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
          contentPadding: const EdgeInsets.only(top: 5, left: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 0,
              color: ProjectColors.mainGray,
            ),
            gapPadding: 0,
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(7),
          //   // borderSide: const BorderSide(width: 1.5, color: Colors.grey),
          // ),
          fillColor: ProjectColors.mainGray,
          filled: true,
        ),

        // onChanged: (text) {
        //   keyBoardProvider.setKeyboardOpen(text.isNotEmpty);
        // },
      ),
    );
  }
}
