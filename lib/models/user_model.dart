import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialscan/models/social_link_model.dart';

class UserModel {
  final String id;
  final String image;
  final String fullName;
  // final String lastName;
  final String phoneNumber;
  final String email;
  String? password;
  final String? profession;
  final List<SocialLinkModel>? socialMediaLink;

  UserModel({
    required this.fullName,
    // required this.lastName,
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
    data['fullName'] = fullName;
    // data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['profession'] = profession;
    data['id'] = id;
    data['image'] = image;
    data['socialMediaLink'] = socialMediaLink?.map((e) => e.toJson());
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      // 'lastName': lastName,
      'phoneNumber': phoneNumber,
      'profession': profession,
      'email': email,
      'image': image,
      'socialMediaLink': socialMediaLink?.map((e) => e.toJson()).toList(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      // lullName: json['lastName'] ?? '',
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
      fullName: documentSnapShot['fullName'] ?? '',
      // fName: documentSnapShot['lastName'] ?? '',
      phoneNumber: documentSnapShot['phoneNumber'] ?? '',
      password: documentSnapShot['password'] ?? '',
      email: documentSnapShot['email'] ?? '',
      profession: documentSnapShot['profession'] ?? '',
      id: documentSnapShot['id'] ?? '',
      image: documentSnapShot['image'] ?? '',
      socialMediaLink: (documentSnapShot['socialMediaLink'] as List<dynamic>?)
              ?.map((linkJson) => SocialLinkModel.fromJson(linkJson))
              .toList() ??
          [],
    );
  }
}
