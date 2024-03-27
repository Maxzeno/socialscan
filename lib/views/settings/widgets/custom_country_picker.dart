import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class CustomCountryField extends StatefulWidget {
  const CustomCountryField({super.key});

  @override
  State<CustomCountryField> createState() => _CustomCountryFieldState();
}

class _CustomCountryFieldState extends State<CustomCountryField> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: ProjectColors.midBlack,
        ),
        maxLines: 1,
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
                      child: countryCode?.flagImage(fit: BoxFit.fill, width: 19),
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
