import 'package:flutter/material.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/social_lists_widget.dart';
import 'package:socialscan/views/home/widgets/text_tile_widget.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage({super.key});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextTileWidget(
            text: mySocials,
            size: 16,
            // icon: addedSocialsList.isEmpty
            //     ? const SizedBox()
            //     : SizedBox(
            //         height: 20,
            //         width: 20,
            //         child: Checkbox(
            //           value: isChecked,
            //           activeColor: ProjectColors.mainPurple,
            //           side: const BorderSide(width: 1),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           onChanged: (val) {
            //             setState(() {
            //               isChecked = !isChecked;
            //             });
            //           },
            //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //           visualDensity: VisualDensity.compact,
            //         ),
            //       ),
            icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: ProjectColors.mainPurple,
                      side: const BorderSide(width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (val) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
          ),
          const SizedBox(
            height: 14,
          ),
          SocialListsWidget(
            isAllMediasChecked: isChecked,
          ),
          const SizedBox(
            height: 55,
          ),
        ],
      ),
    );
  }
}
