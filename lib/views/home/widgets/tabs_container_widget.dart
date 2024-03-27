import 'package:flutter/material.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:socialscan/utils/images.dart';
import 'package:socialscan/utils/strings.dart';
import 'package:socialscan/views/home/widgets/tab_text_tile.dart';

class TabsContainerWidget extends StatefulWidget {
  const TabsContainerWidget({super.key});

  @override
  State<TabsContainerWidget> createState() => _TabsContainerWidgetState();
}

class _TabsContainerWidgetState extends State<TabsContainerWidget> {
int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 17,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: ProjectColors.tabBgColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(94),
      ),
      child: TabBar(
        labelColor: ProjectColors.mainPurple,
        unselectedLabelColor: Colors.black,
        splashBorderRadius: BorderRadius.circular(94),
        indicatorColor: Colors.transparent,
        indicatorPadding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(94),
          // border: Border.all(color: darkGrey),
        ),
        tabs: [
          TabTextTile(
              iconPath: _selectedIndex == 0 ? homeIconFill : homeIcon,
              text: home,
              isSelected: _selectedIndex == 0),
          TabTextTile(
              iconPath: _selectedIndex == 1 ? networkIconFill : networkIcon,
              text: network,
              isSelected: _selectedIndex == 1),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}