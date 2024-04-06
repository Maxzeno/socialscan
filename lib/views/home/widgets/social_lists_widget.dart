import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';
import 'package:socialscan/views/home/screens/qr_code_screen.dart';
import 'package:socialscan/views/home/widgets/social_media_tile.dart';

import '../../../utils/button.dart';
import '../screens/edit_social_screen.dart';
import '../screens/scan_qr_code.dart';

class SocialListsWidget extends StatefulWidget {
  const SocialListsWidget({super.key});

  @override
  State<SocialListsWidget> createState() => _SocialListsWidgetState();
}

class _SocialListsWidgetState extends State<SocialListsWidget> {
  SocialLinkModel? selectedSocialMedia;
  TextEditingController linkController = TextEditingController();

  bool isVisible = false;
  List<SocialLinkModel> socialLinks = [
    SocialLinkModel(
      text: faceBook,
      imagePath: faceBookIcon,
      conColor: ProjectColors.fb,
      iconColor: ProjectColors.fb.withOpacity(0.5),
      id: 0,
      linkUrl: '',
    ),
    SocialLinkModel(
      text: instagram,
      imagePath: instagramIcon,
      conColor: ProjectColors.ig,
      iconColor: ProjectColors.ig.withOpacity(0.5),
      id: 1,
      linkUrl: '',
    ),
    SocialLinkModel(
      text: whatsApp,
      imagePath: whatsAppIcon,
      conColor: ProjectColors.wsa,
      iconColor: ProjectColors.wsa.withOpacity(0.5),
      id: 2,
      linkUrl: '',
    ),
    SocialLinkModel(
      text: twitter,
      imagePath: twitterIcon,
      conColor: ProjectColors.x,
      iconColor: ProjectColors.x.withOpacity(0.5),
      id: 3,
      linkUrl: '',
    ),
    SocialLinkModel(
      text: linkedin,
      imagePath: linkedInIcon,
      conColor: ProjectColors.li,
      iconColor: ProjectColors.li.withOpacity(0.5),
      id: 4,
      linkUrl: '',
    ),
  ];

  List<String> extractLinkUrls(List<SocialLinkModel> socialLinks) {
    List<String> linkUrls = [];
    for (var socialLink in socialLinks) {
      linkUrls.add(socialLink.linkUrl ?? ''); // Add link URL to the list
    }
    return linkUrls;
  }

  List<SocialLinkModel> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<SocialLinkModel> dropdownItems = List.from(socialLinks);

    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 2.3 / 2.1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          itemCount: selectedItems.length + 1,
          itemBuilder: (context, index) {
            if (index == selectedItems.length) {
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
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState1) {
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 19),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFECECEC),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: DropdownButton<SocialLinkModel>(
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
                                      onChanged: (newValue) {
                                        setState1(() {
                                          selectedSocialMedia = newValue;
                                          print(
                                              'Selected ===> $selectedSocialMedia');
                                        });
                                      },
                                      items: dropdownItems.map<
                                              DropdownMenuItem<
                                                  SocialLinkModel>>(
                                          (SocialLinkModel? value) {
                                        return DropdownMenuItem<
                                            SocialLinkModel>(
                                          value: value,
                                          child: value != null
                                              ? Text(
                                                  value!.text,
                                                  style: TextStyle(
                                                    color: selectedItems
                                                            .contains(value)
                                                        ? Colors.grey
                                                        : Colors.black,
                                                  ),
                                                )
                                              : const Text(
                                                  'Select Social Media'),
                                          enabled:
                                              !selectedItems.contains(value),
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
                                  controller: linkController,
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
                                ButtonTile(
                                    text: 'Add',
                                    boxRadius: 10,
                                    width: 338,
                                    onTap: () {
                                      setState(() {
                                        final link = selectedSocialMedia!
                                            .linkUrl = linkController.text;
                                        selectedItems.add(selectedSocialMedia!);
                                        // dropdownItems.remove(selectedSocialMedia);
                                      });
                                      print(
                                          'Added =====> $selectedSocialMedia');
                                      print(
                                          'Added Lists =====> $selectedItems');
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          );
                        });
                      });
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
                          backgroundColor:
                              ProjectColors.midBlack.withOpacity(0.1),
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
            final data = selectedItems[index];
            print('data =====> $data');
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      socialColor: data.conColor!,
                      socialText: data.text,
                      icon: data.imagePath,
                      linkUrl: data.linkUrl,
                    ),
                  ),
                );
              },
              onLongPress: () {
                print('CLicked');
              },
              child: SocialMediaTile(
                socialImage: data.imagePath!,
                socialIconColor: data.iconColor!,
                conColor: data.conColor!,
                socialText: data.text,
              ),
            );
          },
        ),
        const SizedBox(
          height: 55,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonTile(
              width: 130,
              text: connect,
              boxRadius: 25,
              icon: const Icon(
                Icons.qr_code,
                color: Colors.white,
              ),
              onTap: () {
                List<String> allLinks = extractLinkUrls(socialLinks);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QrCodeScreen(
                      qrData: allLinks,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            ButtonTile(
              width: 140,
              text: scan,
              boxRadius: 25,
              icon: SvgPicture.asset(
                connectIcon,
                height: 24,
                width: 24,
              ),
              onTap: () {
                List<String> allLinks = extractLinkUrls(socialLinks);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ScanQrCode(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
