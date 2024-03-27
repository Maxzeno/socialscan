import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/views/home/widgets/social_media_tile.dart';

class SocialListsWidget extends StatelessWidget {
  const SocialListsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedSocialMedia;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 2.3 / 2.1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      shrinkWrap: true,
      itemCount: socialLinks.length + 1,
      itemBuilder: (context, index) {
        if (index == socialLinks.length) {
          return GestureDetector(
            onTap: () {
              // print(MediaQuery.of(context).size.height);
              showBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: screenHeight * 0.45,
                      width: screenWidth,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHeight / 40,
                        vertical: screenHeight / 35,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                print('Clike');
                              },
                              child: const Icon(
                                Icons.close_rounded,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            addNewSocial,
                            style: GoogleFonts.montserrat(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            width: 338,
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            decoration: BoxDecoration(
                              color: const Color(0xFFECECEC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                value: selectedSocialMedia,
                                hint: const Text(
                                  'Select social Media',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSocialMedia = newValue!;
                                    print('Selected ===> $selectedSocialMedia');
                                  });
                                },
                                items: <String>[
                                  'Facebook',
                                  'Instagram',
                                  'Whatsapp',
                                  'LinkedIn',
                                  'Twitter',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                icon: SvgPicture.asset(
                                  downArrowIcon,
                                  height: 7,
                                  width: 13,
                                  color: ProjectColors.midBlack,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          ReusableTextField(
                            onTap: () {},
                            hintText: 'Paste Link',
                            width: 338,
                            obscure: false,
                            iconButton: const InkWell(
                              child: Icon(
                                Icons.paste_rounded,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const ButtonTile(
                            text: 'Add',
                            boxRadius: 10,
                            width: 338,
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            },
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(8),
              strokeWidth: 1.5,
              dashPattern: const [8, 8],
              color: ProjectColors.midBlack.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: ProjectColors.midBlack.withOpacity(0.1),
                      child: SvgPicture.asset(
                        addIcon,
                        height: 22,
                        width: 22,
                        color: ProjectColors.midBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      addNew,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ProjectColors.midBlack.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        final data = socialLinks[index];
        return SocialMediaTile(
          socialImage: data.imagePath,
          socialIconColor: data.iconColor,
          conColor: data.conColor,
          socialText: data.text,
        );
      },
    );
  }
}
