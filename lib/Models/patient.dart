import 'dart:convert';

Paginations paginationsFromJson(String str) =>
    Paginations.fromJson(json.decode(str));

String paginationsToJson(Paginations data) => json.encode(data.toJson());

class Paginations {
  Paginations({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  int pageIndex;
  int pageSize;
  int count;
  List<Patient> data;

  factory Paginations.fromJson(Map<String, dynamic> json) => Paginations(
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        count: json["count"],

        data: List<Patient>.from(json["data"].map((x) => Patient.fromJson(x))),
        // data: List<List<Patient>>.from(json["data"]
        //     .map((x) => List<Patient>.from(x.map((x) => Patient.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Patient {
  Patient({
    required this.id,
    required this.hospitalId,
    required this.hospitalName,
    required this.firstName,
    required this.lastName,
    required this.doB,
    required this.mobileNumber,
    required this.gender,
    required this.maritalStatus,
    required this.primaryMember,
    required this.membershipRegistrationNumber,
    required this.address,
    required this.divisionId,
    required this.division,
    required this.upazilaId,
    required this.upazila,
    required this.districtId,
    required this.district,
    required this.nid,
    required this.bloodGroup,
    required this.branchId,
    required this.branchName,
    required this.isActive,
    required this.note,
    required this.covidvaccine,
    required this.vaccineBrand,
    required this.vaccineDose,
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.userName,
  });

  int id;
  int? hospitalId;
  String? hospitalName;
  String? firstName;
  String? lastName;
  DateTime? doB;
  String? mobileNumber;
  String? gender;
  String? maritalStatus;
  bool? primaryMember;
  String? membershipRegistrationNumber;
  String? address;
  int? divisionId;
  String? division;
  int? upazilaId;
  String upazila;
  int? districtId;
  String? district;
  String? nid;
  String? bloodGroup;
  int? branchId;
  String? branchName;
  bool isActive;
  String? note;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  DateTime? createdOn;
  String? createdBy;
  DateTime? updatedOn;
  String? updatedBy;
  String? userName;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        doB: DateTime.parse(json["doB"]),
        mobileNumber: json["mobileNumber"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        primaryMember: json["primaryMember"],
        membershipRegistrationNumber: json["membershipRegistrationNumber"],
        address: json["address"],
        divisionId: json["divisionId"],
        division: json["division"],
        upazilaId: json["upazilaId"],
        upazila: json["upazila"],
        districtId: json["districtId"],
        district: json["district"],
        nid: json["nid"],
        bloodGroup: json["bloodGroup"],
        branchId: json["branchId"],
        branchName: json["branchName"],
        isActive: json["isActive"],
        note: json["note"],
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "firstName": firstName,
        "lastName": lastName,
        "doB": doB,
        "mobileNumber": mobileNumber,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "primaryMember": primaryMember,
        "membershipRegistrationNumber": membershipRegistrationNumber,
        "address": address,
        "divisionId": divisionId,
        "division": division,
        "upazilaId": upazilaId,
        "upazila": upazila,
        "districtId": districtId,
        "district": district,
        "nid": nid,
        "bloodGroup": bloodGroup,
        "branchId": branchId,
        "branchName": branchName,
        "isActive": isActive,
        "note": note,
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "createdOn": createdOn,
        "createdBy": createdBy,
        "updatedOn": updatedOn,
        "updatedBy": updatedBy,
        "userName": userName,
      };
}
