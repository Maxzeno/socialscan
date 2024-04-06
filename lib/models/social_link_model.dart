import 'dart:ui';

class SocialLinkModel {
  final int? id;
  final String text;
  final String? imagePath;
  final Color? conColor;
  final Color? iconColor;
  String linkUrl;
  SocialLinkModel({
    required this.text,
    this.imagePath,
    this.conColor,
    this.iconColor,
    this.linkUrl = '',
    this.id,
  });
}
