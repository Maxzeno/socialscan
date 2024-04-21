import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/services/firebase_services.dart';

import '../../../utils/textfield.dart';

class EditSocialDetailsScreen extends StatefulWidget {
  final Color socialColor;
  final String socialText;
  final dynamic icon;
  final String linkUrl;
  final String id;
  const EditSocialDetailsScreen({
    super.key,
    required this.socialColor,
    required this.socialText,
    this.icon,
    required this.linkUrl,
    required this.id,
  });

  @override
  State<EditSocialDetailsScreen> createState() =>
      _EditSocialDetailsScreenState();
}

String link = '';

class _EditSocialDetailsScreenState extends State<EditSocialDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print('this link ====> ${widget.linkUrl}');
    print('this id ====> ${widget.id}');
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackgroundBox(
                  theChild: Container(
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                      color: widget.socialColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          // blurStyle: BlurStyle.outer,
                          color: widget.socialColor,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        widget.icon,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  text: widget.socialText,
                  color: widget.socialColor.withOpacity(0.1),
                ),
                const SizedBox(
                  height: 40,
                ),
                // Text(
                //   'Social Media',
                //   style: GoogleFonts.montserrat(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //     color: Colors.black38,
                //   ),
                // ),
                // const SizedBox(height: 5),
                Container(
                  height: 53,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ProjectColors.mainGray,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: widget.socialColor,
                        radius: 16,
                        child: SvgPicture.asset(
                          widget.icon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.socialText,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Link',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 5),
                ReusableTextField(
                  onTap: () {},
                  hintText: 'Paste Link',
                  initialValue: widget.linkUrl,
                  width: double.infinity,
                  obscure: false,
                  iconButton: const InkWell(
                    child: Icon(
                      Icons.paste_rounded,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                  onSaved: (value) {
                    link = value!;
                  },
                ),
                const SizedBox(
                  height: 110,
                ),
                ButtonTile(
                  onTap: () {
                    FirebaseService().editSocialLink(widget.id, link).then(
                          (value) => infoSnackBar(
                              context,
                              'Social Updated Successful',
                              const Duration(milliseconds: 400),
                              Colors.green),
                        );
                    link = '';
                    setState(() {});
                  },
                  text: 'Save',
                  boxRadius: 8,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          width: 1,
                          color: ProjectColors.mainPurple,
                        ),
                      ),
                    ),
                    onPressed: () {
                      FirebaseService()
                          .deleteSocialLink(
                            widget.id,
                          )
                          .then(
                            (value) => infoSnackBar(
                                context,
                                'Deleted Social Successful',
                                const Duration(milliseconds: 300),
                                Colors.green),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: ProjectColors.mainPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundBox extends StatelessWidget {
  const BackgroundBox({
    Key? key,
    required this.theChild,
    this.color,
    required this.text,
  }) : super(key: key);

  final Widget theChild;
  final Color? color;
  final String text;

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
                color: color,
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
                    height: 40,
                  ),
                  Text(
                    text,
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
