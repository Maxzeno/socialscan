import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/models/social_link_model.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/lists/added_socials_list.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/utils/textfield.dart';

class AddNewSocialWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final List<SocialLinkModel> dropdownItems;
  final TextEditingController linkController;
  final StateSetter setState1;
  final void Function(SocialLinkModel) addSocial;

  const AddNewSocialWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.dropdownItems,
    required this.linkController,
    required this.setState1,
    required this.addSocial,
  });

  @override
  State<AddNewSocialWidget> createState() => _AddNewSocialWidgetState();
}

class _AddNewSocialWidgetState extends State<AddNewSocialWidget> {
  SocialLinkModel? selectedSocialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.45,
      width: widget.screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenHeight / 40,
        vertical: widget.screenHeight / 35,
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
            style: const TextStyle(
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
                  widget.setState1(() {
                    selectedSocialMedia = newValue;
                    print('Selected ===> $selectedSocialMedia');
                  });
                },
                items: widget.dropdownItems
                    .map<DropdownMenuItem<SocialLinkModel>>(
                        (SocialLinkModel? value) {
                  return DropdownMenuItem<SocialLinkModel>(
                    value: value,
                    enabled: !addedSocialsList.contains(value),
                    child: value != null
                        ? Text(
                            value.text,
                            style: TextStyle(
                              color: addedSocialsList.contains(value)
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          )
                        : const Text('Select Social Media'),
                  );
                }).toList(),
                icon: SvgPicture.asset(
                  downArrowIcon,
                  height: 7,
                  width: 13,
                  colorFilter: const ColorFilter.mode(
                      ProjectColors.midBlack, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ReusableTextField(
            controller: widget.linkController,
            onTap: () {},
            hintText: 'Paste Link',
            width: 338,
            obscure: false,
            iconButton: InkWell(
              onTap: () async {
                // ClipboardData? data = await Clipboard.getData('text/plain');
                // setState(() {
                //   widget.linkController.text = data!.text
                //       .toString(); // this will paste "copied text" to textFieldController
                // });
              },
              child: const Icon(
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
              onTap: () async{
                // setState(() {
                //   final link = selectedSocialMedia!.linkUrl =
                //       widget.linkController.text;
                //   addedSocialsList.add(selectedSocialMedia!);
                //   // dropdownItems.remove(selectedSocialMedia);
                // });
                // print('Added =====> $selectedSocialMedia');
                // print('Added Lists =====> $addedSocialsList.');
                // Navigator.pop(context);
                // setState(() {

                // });

                widget.addSocial(selectedSocialMedia!);
                Navigator.pop(context);
                
              }),
        ],
      ),
    );
  }
}