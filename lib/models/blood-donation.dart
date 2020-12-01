import 'package:flutter_app/models/blood-request.dart';
import 'package:flutter_app/models/user.dart';

class BloodDonationModel {
  BloodDonationModel(
    this.id,
    this.user,
    this.bloodRequest,
    this.contactNumber,
    this.numOfBottles,
  );

  factory BloodDonationModel.fromJson(Map<String, dynamic> json) {
    return BloodDonationModel(
      json['id'],
      UserModel.fromJson(json['user']),
      BloodRequestModel.fromJson(json['blood_request']),
      json['contact_number'],
      json['num_of_bottles'] is int? json['num_of_bottles']: int.parse(json['num_of_bottles']),
    );
  }

  int id;
  BloodRequestModel bloodRequest;
  UserModel user;
  String contactNumber;
  String bloodType;
  int numOfBottles;
  String location;
  String createdAt;
}
