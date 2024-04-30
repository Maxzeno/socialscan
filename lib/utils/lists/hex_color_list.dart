import 'package:flutter/material.dart';
import 'package:socialscan/utils/colors.dart';

String colorToHex(Color color) {
  return color.value.toRadixString(16);
}

final String newLinkId = DateTime.now().millisecondsSinceEpoch.toString();

const fbConColor = ProjectColors.fb;
final fbIconColor = fbConColor.withOpacity(0.5);

const igConColor = ProjectColors.ig;
final igIconColor = igConColor.withOpacity(0.5);

const xConColor = ProjectColors.x;
final xIconColor = xConColor.withOpacity(0.5);

const wsaConColor = ProjectColors.wsa;
final wsaIconColor = wsaConColor.withOpacity(0.5);

const liConColor = ProjectColors.li;
final liIconColor = liConColor.withOpacity(0.5);

const scConColor = ProjectColors.sc;
final scIconColor = scConColor.withOpacity(0.5);

const ghConColor = ProjectColors.gh;
final ghIconColor = ghConColor.withOpacity(0.5);
