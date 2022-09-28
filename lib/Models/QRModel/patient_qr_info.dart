import 'dart:convert';

PatientQRInfo PatientQRInfoFromJson(String str) =>
    PatientQRInfo.fromJson(json.decode(str));

String PatientQRInfoToJson(PatientQRInfo data) => json.encode(data.toJson());

class PatientQRInfo {
  PatientQRInfo({
    required this.id,
    this.firstname,
    this.lastname,
    this.mobileNumber,
  });

  int id;
  String? firstname;
  String? lastname;
  String? mobileNumber;

  factory PatientQRInfo.fromJson(Map<String, dynamic> json) => PatientQRInfo(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "mobileNumber": mobileNumber,
      };
}
