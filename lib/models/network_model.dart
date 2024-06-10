import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialscan/models/user_model.dart';

class NetWorkModel {
  final UserModel userModel;
  final DateTime dateTime;

  NetWorkModel({
    required this.userModel,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userModel'] = userModel.toJson(); // Convert userModel to JSON
    data['dateTime'] =
        Timestamp.fromDate(dateTime); // Convert DateTime to Timestamp
    return data;
  }

  factory NetWorkModel.fromJson(Map<String, dynamic> json) {
    final timestamp =
        json['dateTime'] as Timestamp?; // Handle potential null value
    final userModel = UserModel.fromJson(json['userModel']);
    return NetWorkModel(
      userModel: userModel,
      dateTime: timestamp?.toDate() ??
          DateTime.now(), // Use default now if no timestamp found
    );
  }

  static NetWorkModel fromSnap(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return NetWorkModel(
      userModel: UserModel.fromJson(
          data['userModel'] ?? {}), // Handle potential null value
      dateTime: data['dateTime']?.toDate() ??
          DateTime.now(), // Use default now if no timestamp found
    );
  }
}
