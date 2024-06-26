import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox({
    Key? key,
    required this.theChild,
    this.title,
    required this.background,
    required this.subTitle,
  }) : super(key: key);

  final Widget theChild;
  final String? title;
  final String subTitle;
  final dynamic background;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Container(
        height: 313,
        width: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            // Blur effect (BackdropFilter)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4.0,
                sigmaY: 4.0,
              ),
              child: background,
            ),
            // Gradient effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.13),
                ), // Adjust opacity as needed
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: Theme.of(context).brightness == Brightness.light ? [
                    Colors.grey.shade50
                        .withOpacity(0.9), // Adjust opacity as needed
                    Colors.grey.shade50
                        .withOpacity(0.8), // Adjust opacity as needed
                  ] : [
                    ProjectColors.bgBlack
                        .withOpacity(0.6), // Adjust opacity as needed
                    ProjectColors.bgBlack
                        .withOpacity(0.5), // Adjust opacity as needed
                  ],
                ),
              ),
            ),
            // Child widget
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  theChild,
                  const SizedBox(
                    height: 15,
                  ),
                  if (title != null)
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).brightness == Brightness.light ? ProjectColors.midBlack : Colors.white,
                      ),
                    ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.light ? ProjectColors.midBlack.withOpacity(0.5) : Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
