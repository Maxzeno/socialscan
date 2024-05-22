import 'package:flutter/material.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/social_lists_widget.dart';
import 'package:socialscan/views/home/widgets/text_tile_widget.dart';

class SocialsPage extends StatefulWidget {
  const SocialsPage({super.key});

  @override
  State<SocialsPage> createState() => _SocialsPageState();
}

class _SocialsPageState extends State<SocialsPage> {
  final bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);



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
            //           value: _isChecked,
            //           activeColor: ProjectColors.mainPurple,
            //           side: const BorderSide(width: 1),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           onChanged: (val) {
            //             setState(() {
            //               _isChecked = !_isChecked;
            //             });
            //           },
            //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //           visualDensity: VisualDensity.compact,
            //         ),
            //       ),
            // icon: SizedBox(
            //   height: 20,
            //   width: 20,
            //   child: Checkbox(
            //     value: _isChecked,
            //     activeColor: ProjectColors.mainPurple,
            //     side: const BorderSide(width: 1),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     onChanged: (val) {
            //       setState(() {
            //         _isChecked = !_isChecked;
            //       });

            //       // setState(() {
            //       //   _isChecked = val!;
            //       //   log("_isAllSocialChecked: $_isChecked");
            //       //   log("selectedSocialsToSendList: $selectedSocialsToSendList");
            //       //   userProvider.selectSocialToQrCode(
            //       //     _isChecked,
            //       //     data,
            //       //     index,
            //       //   );
            //       // });

            //       // setState(() {
            //       //   _isChecked = !_isChecked;
            //       //   log("_isAllSocialChecked: $_isChecked");
            //       //   if (_isChecked) {
            //       //     userProvider.selectAllSocials(
            //       //         _isChecked, addedSocialsList);
            //       //   } else {
            //       //     userProvider.selectSocialToQrCode(_isChecked, "data", -1);
            //       //   }
            //       //   log("selectedSocialsToSendList: $selectedSocialsToSendList");
            //       // });
            //     },
            //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     visualDensity: VisualDensity.compact,
            //   ),
            // ),
          ),
          const SizedBox(
            height: 14,
          ),
          SocialListsWidget(
            isAllMediasChecked: _isChecked,
          ),
          const SizedBox(
            height: 55,
          ),
        ],
      ),
    );
  }
}
