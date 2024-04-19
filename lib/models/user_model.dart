import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialscan/models/social_link_model.dart';

class UserModel {
  final String id;
  final String image;
  final String firstName;
  final String lastName;
  final dynamic phoneNumber;
  final String email;
  String? password;
  final String? profession;
  final List<SocialLinkModel>? socialMediaLink;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.password,
    required this.profession,
    required this.email,
    required this.id,
    required this.image,
    this.socialMediaLink,
  });
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['profession'] = profession;
    data['id'] = id;
    data['image'] = image;
    data['socialMediaLink'] = socialMediaLink;
    return data;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      profession: json['profession'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? '',
      socialMediaLink: (json['socialMediaLink'] as List<dynamic>?)
              ?.map((linkJson) => SocialLinkModel.fromJson(linkJson))
              .toList() ??
          [],
    );
  }
  static UserModel fromSnap(DocumentSnapshot snapshot) {
    var documentSnapShot = snapshot.data() as Map<String, dynamic>;
    print('User Document snapshot==========>$documentSnapShot<========');
    return UserModel(
      firstName: documentSnapShot['firstName'],
      lastName: documentSnapShot['lastName'],
      phoneNumber: documentSnapShot['phoneNumber'],
      password: documentSnapShot['password'],
      email: documentSnapShot['email'],
      profession: documentSnapShot['profession'],
      id: documentSnapShot['id'],
      image: documentSnapShot['image'],
      socialMediaLink: (documentSnapShot['socialMediaLink'] as List<dynamic>?)
              ?.map((linkJson) => SocialLinkModel.fromJson(linkJson))
              .toList() ??
          [],
    );
  }
}
