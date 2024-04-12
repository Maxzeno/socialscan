import 'package:socialscan/models/social_link_model.dart';

class ScannedUserModel{
  final int? id;
  final String? profilePicLink;
  final String fullName;
  final String profession;
  final String? email;
  final String? phoneNumber;
  final List<SocialLinkModel> socialMediaLink;

  ScannedUserModel({
     this.id,
     this.profilePicLink,
    required this.fullName,
    required this.profession,
    this.email,
    this.phoneNumber,
    required this.socialMediaLink,
  });
}