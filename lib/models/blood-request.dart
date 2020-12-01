import 'package:flutter_app/models/user.dart';

class BloodRequestModel {
  BloodRequestModel(this.id, this.user, this.contactNumber, this.bloodType, this.numOfBottles,
      this.location, this.createdAt);

  factory BloodRequestModel.fromJson(Map<String, dynamic> json) {
    return BloodRequestModel(
        json['id'],
        UserModel.fromJson(json['user']),
        json['contact_number'],
        json['blood_type'],
        json['num_of_bottles'],
        json['location'],
        json['created_at']);
  }

  int id;
  UserModel user;
  String contactNumber;
  String bloodType;
  int numOfBottles;
  String location;
  String createdAt;
}
