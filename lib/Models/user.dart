// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.userId,
    // this.hospitalId,
    // this.hospitalName,
    this.firstName,
    this.lastName,
    // this.email,
    this.phoneNumber,
    // this.designation,
    // this.bmdcRegNo,
    // this.optionalEmail,
    // this.joiningDate,
    // this.lastLoginDate,
    // this.createdOn,
    // this.createdBy,
    // this.updatedOn,
    // this.updatedBy,
    // this.isActive,
    // this.role,
  });

  String? userId;
  // int? hospitalId;
  // String? hospitalName;
  String? firstName;
  String? lastName;
  // String? email;
  String? phoneNumber;
  // String? designation;
  // String? bmdcRegNo;
  // String? optionalEmail;
  // DateTime? joiningDate;
  // DateTime? lastLoginDate;
  // DateTime? createdOn;
  // String? createdBy;
  // DateTime? updatedOn;
  // String? updatedBy;
  // bool? isActive;
  // String? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        // hospitalId: json["hospitalId"],
        // hospitalName: json["hospitalName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        // email: json["email"],
        phoneNumber: json["phoneNumber"],
        // designation: json["designation"],
        // bmdcRegNo: json["bmdcRegNo"],
        // optionalEmail: json["optionalEmail"],
        // joiningDate: DateTime.parse(json["joiningDate"]),
        // lastLoginDate: DateTime.parse(json["lastLoginDate"]),
        // createdOn: DateTime.parse(json["createdOn"]),
        // createdBy: json["createdBy"],
        // updatedOn: DateTime.parse(json["updatedOn"]),
        // updatedBy: json["updatedBy"],
        // isActive: json["isActive"],
        // role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        // "hospitalId": hospitalId,
        // "hospitalName": hospitalName,
        "firstName": firstName,
        "lastName": lastName,
        // "email": email,
        "phoneNumber": phoneNumber,
        // "designation": designation,
        // "bmdcRegNo": bmdcRegNo,
        // "optionalEmail": optionalEmail,
        // "joiningDate": joiningDate,
        // "lastLoginDate": lastLoginDate,
        // "createdOn": createdOn,
        // "createdBy": createdBy,
        // "updatedOn": updatedOn,
        // "updatedBy": updatedBy,
        // "isActive": isActive,
        // "role": role,
      };
}
