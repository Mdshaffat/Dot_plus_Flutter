// To parse this JSON data, do
//
//     final searchPatient = searchPatientFromJson(jsonString);

import 'dart:convert';

List<SearchPatient> searchPatientFromJson(String str) =>
    List<SearchPatient>.from(
        json.decode(str).map((x) => SearchPatient.fromJson(x)));

String searchPatientToJson(List<SearchPatient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPatient {
  SearchPatient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  int id;
  String? firstName;
  String? lastName;
  String? mobileNumber;

  factory SearchPatient.fromJson(Map<String, dynamic> json) => SearchPatient(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
      };
}
