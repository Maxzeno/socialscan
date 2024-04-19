import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class CustomCountryField extends StatefulWidget {
  final String initialValue;
  final dynamic onSave;
  const CustomCountryField(
      {super.key, required this.initialValue, this.onSave});

  @override
  State<CustomCountryField> createState() => _CustomCountryFieldState();
}

class _CustomCountryFieldState extends State<CustomCountryField> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

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
        initialValue: widget.initialValue ?? '',
        textInputAction: TextInputAction.done,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: ProjectColors.midBlack,
        ),
        maxLines: 1,
        onSaved: widget.onSave,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          prefixIcon: GestureDetector(
            onTap: () async {
              final code = await countryPicker.showPicker(context: context);
              setState(() {
                countryCode = code;
              });
            },
            child: Container(
              width: 75,
              margin: const EdgeInsets.symmetric(
                horizontal: 19,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
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
                      ),
                      child:
                          countryCode?.flagImage(fit: BoxFit.fill, width: 19),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    countryCode?.dialCode ?? "+1",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          fillColor: ProjectColors.mainGray,
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
