import 'package:flutter/material.dart';

class HorizontalDotTile extends StatelessWidget {
  const HorizontalDotTile({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrains) {
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            (constrains.constrainWidth() / 10).floor(),
            (index) => SizedBox(
              width: 7,
              height: 1.5,
              // width: AppLayOut.getWidth(4),
              // height: AppLayOut.getHeight(1),
              // width: 4,
              // height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
