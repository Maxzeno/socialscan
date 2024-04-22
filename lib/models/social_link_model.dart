import 'dart:ui';

class SocialLinkModel {
  String? id;
  final String text;
  final String? imagePath;
  final Color? conColor;
  final Color? iconColor;
  String linkUrl;
  SocialLinkModel({
    required this.text,
    this.imagePath,
    this.id,
    this.conColor,
    this.iconColor,
    this.linkUrl = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'imagePath': imagePath,
      'conColor': conColor?.toHex(), // Check for nullability
      'iconColor': iconColor?.toHex(), // Check for nullability
      'linkUrl': linkUrl,
      'id': id,
    };
  }

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) {
    return SocialLinkModel(
      text: json['text'],
      imagePath: json['imagePath'],
      conColor: json['conColor'] != null
          ? Color(int.parse(json['conColor'].replaceFirst('#', ''), radix: 16) +
              0xFF000000)
          : null,
      iconColor: json['iconColor'] != null
          ? Color(
              int.parse(json['iconColor'].replaceFirst('#', ''), radix: 16) +
                  0xFF000000)
          : null,
      linkUrl: json['linkUrl'],
      id: json['id'],
    );
  }
}

extension ColorExtension on Color {
  // Convert Color to hex string
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
