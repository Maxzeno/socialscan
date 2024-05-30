import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/services/firebase_services.dart';

import '../../../utils/textfield.dart';
import 'package:validated/validated.dart' as validate;

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
  late TextEditingController socialLinkController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socialLinkController = TextEditingController(text: widget.linkUrl);
  }

  @override
  Widget build(BuildContext context) {
    print('this link ====> ${widget.linkUrl}');
    print('this id ====> ${widget.id}');
    return Scaffold(
      // backgroundColor: Colors.white,
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
            // color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
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
                  //   style: TextStyle(
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
                      color: Theme.of(context).brightness == Brightness.light
                          ? ProjectColors.mainGray
                          : ProjectColors.cardBlackColor,
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
                          style: const TextStyle(
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
                  const Text(
                    'Link',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      // color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ReusableTextField(
                    onTap: () {},
                    controller: socialLinkController,
                    hintText: 'Paste Link',
                    // initialValue: widget.linkUrl,
                    validator: (value) {
                      if (value!.isNotEmpty && validate.isURL(value)) {
                        return null;
                      } else {
                        return "Enter a valid link";
                      }
                    },
                    width: double.infinity,
                    obscure: false,
                    iconButton: InkWell(
                      onTap: () async {
                        ClipboardData? data =
                            await Clipboard.getData('text/plain');
                        setState(() {
                          socialLinkController.text = data!.text
                              .toString(); // this will paste "copied text" to textFieldController
                        });
                      },
                      child: const Icon(
                        Icons.paste_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    onSaved: (value) {
                      socialLinkController.text = value!;
                    },
                  ),
                  // const SizedBox(
                  //   height: 110,
                  // ),
                ],
              ),
            ),
            Column(
              children: [
                ButtonTile(
                  color: socialLinkController.text != widget.linkUrl
                      ? ProjectColors.mainPurple
                      : ProjectColors.mainGray,
                  textColor: socialLinkController.text != widget.linkUrl
                      ? Colors.white
                      : ProjectColors.cardBlackColor.withOpacity(0.6),
                  onTap: () {
                    setState(() {
                      if (socialLinkController.text != widget.linkUrl) {
                        FirebaseService()
                            .editSocialLink(
                                widget.id, socialLinkController.text)
                            .then(
                              (value) => infoSnackBar(
                                context,
                                'Social Updated Successful',
                                const Duration(milliseconds: 400),
                                Colors.green,
                              ),
                            );
                        link = '';
                        setState(() {});
                      } else {
                        return;
                      }
                    });
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
                        BorderSide(
                          width: 1,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ProjectColors.mainPurple
                                  : ProjectColors.lightishPurple,
                        ),
                      ),
                    ),
                    onPressed: () {
                      FirebaseService()
                          .deleteSocialLink(widget.id)
                          .then((value) {
                        infoSnackBar(
                          context,
                          'Deleted Social Successful',
                          const Duration(milliseconds: 200),
                          Colors.green,
                        );
                        Navigator.pop(context);
                      }).catchError((error) {
                        print('Error deleting social link: $error');
                        infoSnackBar(
                          context,
                          'Error deleting social link',
                          const Duration(milliseconds: 200),
                          Colors.red,
                        );
                      });
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        // color: ProjectColors.mainPurple,
                        color: Theme.of(context).brightness == Brightness.light
                            ? ProjectColors.mainPurple
                            : ProjectColors.lightishPurple,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
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
