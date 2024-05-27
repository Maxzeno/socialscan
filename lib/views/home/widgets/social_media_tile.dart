import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/selected_count.dart';

class SocialMediaTile extends StatefulWidget {
  final String socialText;
  final String socialImage;
  final Color socialIconColor;
  final Color conColor;
  final bool isSocialChecked;
  final void Function(bool?) onSelected;

  const SocialMediaTile({
    Key? key,
    required this.socialImage,
    required this.socialIconColor,
    required this.conColor,
    required this.socialText,
    required this.isSocialChecked,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<SocialMediaTile> createState() => _SocialMediaTileState();
}

class _SocialMediaTileState extends State<SocialMediaTile> {
  bool _isChecked = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _isChecked = widget.isSocialChecked;
  // }

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
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 184,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.conColor.withOpacity(0.1),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 53,
                width: 53,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.socialIconColor,
                  border: Border.all(width: 1, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: widget.socialIconColor,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.socialImage,
                    height: 25,
                    width: 25,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                widget.socialText,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  // color: ProjectColors.midBlack.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.scale(
              scale: 1.11,
              child: Checkbox.adaptive(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    widget.onSelected(value);

                    // _onCheckboxSelected(_isChecked);
                  });

                  print(selectedCount);
                },
                // onChanged: widget.onSelected,
                activeColor: ProjectColors.mainPurple,
                checkColor: Colors.white,
                side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? ProjectColors.midBlack
                      : ProjectColors.lightishPurple,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
