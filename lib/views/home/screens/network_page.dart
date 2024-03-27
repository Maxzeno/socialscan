import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/network_list_tile.dart';
import 'package:socialscan/views/home/widgets/text_tile_widget.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Column(
      children: [
        TextTileWidget(
          text: today,
          icon: SvgPicture.asset(
            searchIcon,
            height: 21,
            width: 21,
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        // networkLists(3),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) => const NetworkListTile(),
          separatorBuilder: (context, child) => const SizedBox(
            height: 10,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        TextTileWidget(
          text: yesterday,
          icon: const SizedBox(),
        ),
        const SizedBox(
          height: 18,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) => const NetworkListTile(),
          separatorBuilder: (context, child) => const SizedBox(
            height: 10,
          ),
        ),
      ],
    ),
  );
  }
}