import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/info_snackbar.dart';
import 'package:socialscan/utils/lists/added_socials_list.dart';
import 'package:socialscan/utils/lists/selected_socials_to_send_list.dart';
import 'package:socialscan/utils/lists/social_links_list.dart';
import 'package:socialscan/utils/selected_count.dart';
import 'package:socialscan/utils/services/firebase_services.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/view_model/river_pod/user_notifier.dart';
import 'package:socialscan/views/home/widgets/add_new_social_widget.dart';
import 'package:socialscan/views/home/widgets/social_media_tile.dart';

import '../screens/edit_social_screen.dart';

class SocialListsWidget extends ConsumerStatefulWidget {
  final bool isAllMediasChecked;
  const SocialListsWidget({super.key, required this.isAllMediasChecked});

  @override
  ConsumerState<SocialListsWidget> createState() => _SocialListsWidgetState();
}

class _SocialListsWidgetState extends ConsumerState<SocialListsWidget> {
  addSocial(SocialLinkModel? newItem) async {
    try {
      final message = await FirebaseService().addSocialLink(newItem!);
      log(message);
      if (message == 'Social link added successfully!') {
        setState(() {
          addedSocialsList.add(newItem);
        });
      } else if (message == 'Social link already exists!') {
        infoSnackBar(context, 'Social Media already exists!',
            const Duration(milliseconds: 700), Colors.red);
      } else {
        log('Failed to add social link.');
      }
    } catch (error) {
      log('Error adding social link: $error');
    }
  }

  TextEditingController linkController = TextEditingController();

  List<String> extractLinkUrls(List<SocialLinkModel> socialLinks) {
    List<String> linkUrls = [];
    for (var socialLink in socialLinks) {
      linkUrls.add(socialLink.linkUrl); // Add link URL to the list
    }
    return linkUrls;
  }

  bool _isSocialChecked = false;

  void _onCheckboxSelected(bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        selectedCount++;
      } else {
        selectedCount--;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    linkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    List<SocialLinkModel> dropdownItems = List.from(socialLinks);
    final userSate = ref.read(userProvider.notifier);

    return Column(
      children: [
        StreamBuilder<List<SocialLinkModel>>(
          stream: FirebaseService().getAllSocialMediaLinks(),
          builder: (context, AsyncSnapshot<List<SocialLinkModel>> snapshot) {
            if (snapshot.hasData) {
              final results = snapshot.data!;

              addedSocialsList = results
                  .map((e) => SocialLinkModel.fromJson(e.toJson()))
                  .toList();

              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2.3 / 2.1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemCount: addedSocialsList.length < socialLinks.length
                    ? addedSocialsList.length + 1
                    : addedSocialsList.length,
                itemBuilder: (context, index) {
                  if (index == addedSocialsList.length) {
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
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.white
                                    : Color(0xFF2E2537),
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                      StateSetter setState1) {
                                log('Screen Height: $screenHeight');
                                log('Screen Width: $screenWidth');
                                return AddNewSocialWidget(
                                  screenHeight: screenHeight,
                                  screenWidth: screenWidth,
                                  dropdownItems: dropdownItems,
                                  linkController: linkController,
                                  setState1: setState1,
                                  addSocial: addSocial,
                                );
                              });
                            });
                        log('linkController ====> ${linkController.text}');
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        strokeWidth: 1.5,
                        dashPattern: const [8, 8],
                        color: Theme.of(context).brightness == Brightness.light
                            ? ProjectColors.midBlack.withOpacity(0.3)
                            : Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 33,
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? ProjectColors.midBlack.withOpacity(0.3)
                                    : Colors.white,
                                child: SvgPicture.asset(
                                  addIcon,
                                  height: 22,
                                  width: 22,
                                  // colorFilter: const ColorFilter.mode(
                                  //   ProjectColors.midBlack,
                                  //   BlendMode.srcIn,
                                  // ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                addNew,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  // color:
                                  // ProjectColors.midBlack.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  final data = addedSocialsList[index];
                  // final link = data.linkUrl[0];
                  print('data =====> $data');
                  // print('link =====> $link');
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditSocialDetailsScreen(
                            id: data.id!,
                            socialColor: data.conColor!,
                            socialText: data.text,
                            icon: data.imagePath,
                            linkUrl: data.linkUrl,
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      log('CLicked');
                      print(
                          'Selected list link =====> $selectedSocialsToSendList');

                      // setState(() {
                      //   _isSocialChecked = !_isSocialChecked;
                      // });
                      // selectedSocialsToSendList.add(SocialLinkModel(
                      //   text: data.text,
                      //   imagePath: data.imagePath,
                      //   conColor: data.conColor,
                      //   iconColor: data.iconColor,
                      //   // id: index,
                      //   linkUrl: data.linkUrl,
                      // ));
                    },
                    child: SocialMediaTile(
                      socialImage: data.imagePath!,
                      socialIconColor: data.iconColor!,
                      conColor: data.conColor!,
                      socialText: data.text,
                      isSocialChecked: _isSocialChecked,
                      onSelected: (value) {
                        setState(() {
                          _isSocialChecked = value!;
                          log("_isSocialChecked: $_isSocialChecked");
                          log("selectedSocialsToSendList: $selectedSocialsToSendList");
                        });
                        userSate.selectSocialToQrCode(
                            _isSocialChecked, data, index);

                        _onCheckboxSelected(_isSocialChecked);
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox(
          height: 55,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        // ButtonTile(
        //   width: 130,
        //   text: connect,
        //   boxRadius: 25,
        //   icon: const Icon(
        //     Icons.qr_code,
        //     color: Colors.white,
        //   ),
        //   onTap: () {
        //     List<String> allLinks = extractLinkUrls(socialLinks);
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (_) => QrCodeScreen(
        //           qrData: allLinks,
        //         ),
        //       ),
        //     );
        //   },
        // ),
        //     const SizedBox(
        //       width: 20,
        //     ),
        //     ButtonTile(
        //       width: 140,
        //       text: scan,
        //       boxRadius: 25,
        //       icon: SvgPicture.asset(
        //         connectIcon,
        //         height: 24,
        //         width: 24,
        //       ),
        //       onTap: () {
        //         List<String> allLinks = extractLinkUrls(socialLinks);
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (_) => const ScanQrCode(),
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
