import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:socialscan/utils/colors.dart';

// ignore: must_be_immutable
class CustomCountryField extends StatefulWidget {
  final String? initialValue;
  CountryCode? countryCode;
  final dynamic controller;
  final VoidCallback? onTap;

  final dynamic onSave;
  CustomCountryField({
    super.key,
    this.initialValue,
    this.onSave,
    this.countryCode,
    this.controller,
    this.onTap,
  });

  @override
  State<CustomCountryField> createState() => _CustomCountryFieldState();
}

class _CustomCountryFieldState extends State<CustomCountryField> {
  final countryPicker = FlCountryCodePicker(
    title: const Text("Select"),
    searchBarTextStyle: const TextStyle(color: ProjectColors.midBlack),
    searchBarDecoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Search Country Code',
      hintStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.black38,
      ),
      contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          width: 0,
          color: ProjectColors.mainGray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          width: 0,
          color: ProjectColors.mainGray,
        ),
      ),
    ),
  );

  // void _setCountryCodeFromInitialValue() {
  //   if (widget.initialValue.isNotEmpty) {
  //     final matchingCode = countryPicker.countryCodes
  //         .map((countryCode) =>
  //             CountryCode(dialCode: countryCode, name: '', code: ''))
  //         .firstWhere(
  //           (code) => code.dialCode == widget.initialValue,
  //           orElse: () => CountryCode(
  //             name: 'United States', // Provide a default country name
  //             code: 'US', // Provide a default country code
  //             dialCode: '+1', // Provide a default dial code
  //           ),
  //         );
  //     setState(() {
  //       countryCode = matchingCode;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: widget.controller,
        initialValue: widget.initialValue,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          fontSize: 14,
          color: ProjectColors.midBlack,
        ),
        maxLines: 1,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onSaved: widget.onSave,
        cursorColor: ProjectColors.mainPurple,
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                  .hasMatch(value)) {
            //  r'^[0-9]{10}$' pattern plain match number with length 10
            return "Enter a valid Phone Number";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter Phone number',
          hintStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),
          contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          prefixIcon: GestureDetector(
            onTap: widget.onTap,
            // onTap: () async {
            //   final code = await countryPicker.showPicker(context: context);
            //   setState(() {
            //     widget.countryCode = code;
            //   });
            // },
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(
                horizontal: 19,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black87,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: 19,
                      width: 19,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Theme.of(context).brightness == Brightness.light
                        //     ? ProjectColors.midBlack
                        //     : ProjectColors.mainGray,
                      ),
                      child: widget.countryCode
                          ?.flagImage(fit: BoxFit.fill, width: 19),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.countryCode?.dialCode ?? "+1",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          fillColor: Theme.of(context).brightness == Brightness.light
              ? ProjectColors.mainGray
              : ProjectColors.lightishPurple,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 0,
              color: ProjectColors.mainGray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 0,
              color: ProjectColors.mainGray,
            ),
          ),
        ),
      ),
    );
  }
}
