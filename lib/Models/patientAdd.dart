// To parse this JSON data, do
//
//     final patientAdd = patientAddFromJson(jsonString);

import 'dart:convert';

PatientAdd patientAddFromJson(String str) =>
    PatientAdd.fromJson(json.decode(str));

String patientAddToJson(PatientAdd data) => json.encode(data.toJson());

class PatientAdd {
  PatientAdd({
    required this.hospitalId,
    required this.branchId,
    this.firstName,
    this.lastName,
    this.day,
    this.month,
    this.year,
    this.mobileNumber,
    this.doB,
    this.gender,
    this.maritalStatus,
    this.primaryMember,
    this.membershipRegistrationNumber,
    this.address,
    this.divisionId,
    this.upazilaId,
    this.districtId,
    this.nid,
    this.bloodGroup,
    this.isActive,
    this.note,
    this.covidvaccine,
    this.vaccineBrand,
    this.vaccineDose,
    this.firstDoseDate,
    this.secondDoseDate,
    this.bosterDoseDate,
    this.heightFeet,
    this.heightInches,
    this.weight,
    this.bmi,
    this.bodyTemparature,
    this.appearance,
    this.anemia,
    this.jaundice,
    this.dehydration,
    this.edema,
    this.cyanosis,
    this.heart,
    this.lung,
    this.abdomen,
    this.rbsFbs,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.heartRate,
    this.pulseRate,
    this.spO2,
    this.isLatest,
  });

  int hospitalId;
  int branchId;
  String? firstName;
  String? lastName;
  int? day;
  int? month;
  int? year;
  String? mobileNumber;
  DateTime? doB;
  String? gender;
  String? maritalStatus;
  bool? primaryMember;
  String? membershipRegistrationNumber;
  String? address;
  int? divisionId;
  int? upazilaId;
  int? districtId;
  String? nid;
  String? bloodGroup;
  bool? isActive;
  String? note;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  DateTime? bosterDoseDate;
  int? heightFeet;
  int? heightInches;
  int? weight;
  int? bmi;
  String? bodyTemparature;
  String? appearance;
  String? anemia;
  String? jaundice;
  String? dehydration;
  String? edema;
  String? cyanosis;
  String? heart;
  String? lung;
  String? abdomen;
  String? rbsFbs;
  String? bloodPressureSystolic;
  String? bloodPressureDiastolic;
  String? heartRate;
  int? pulseRate;
  int? spO2;
  bool? isLatest;

  factory PatientAdd.fromJson(Map<String, dynamic> json) => PatientAdd(
        hospitalId: json["hospitalId"],
        branchId: json["branchId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        mobileNumber: json["mobileNumber"],
        doB: DateTime.parse(json["doB"]),
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        primaryMember: json["primaryMember"],
        membershipRegistrationNumber: json["membershipRegistrationNumber"],
        address: json["address"],
        divisionId: json["divisionId"],
        upazilaId: json["upazilaId"],
        districtId: json["districtId"],
        nid: json["nid"],
        bloodGroup: json["bloodGroup"],
        isActive: json["isActive"],
        note: json["note"],
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        firstDoseDate: DateTime.parse(json["firstDoseDate"]),
        secondDoseDate: DateTime.parse(json["secondDoseDate"]),
        bosterDoseDate: DateTime.parse(json["bosterDoseDate"]),
        heightFeet: json["heightFeet"],
        heightInches: json["heightInches"],
        weight: json["weight"],
        bmi: json["bmi"],
        bodyTemparature: json["bodyTemparature"],
        appearance: json["appearance"],
        anemia: json["anemia"],
        jaundice: json["jaundice"],
        dehydration: json["dehydration"],
        edema: json["edema"],
        cyanosis: json["cyanosis"],
        heart: json["heart"],
        lung: json["lung"],
        abdomen: json["abdomen"],
        rbsFbs: json["rbsFbs"],
        bloodPressureSystolic: json["bloodPressureSystolic"],
        bloodPressureDiastolic: json["bloodPressureDiastolic"],
        heartRate: json["heartRate"],
        pulseRate: json["pulseRate"],
        spO2: json["spO2"],
        isLatest: json["isLatest"],
      );

  Map<String, dynamic> toJson() => {
        "hospitalId": hospitalId,
        "branchId": branchId,
        "firstName": firstName,
        "lastName": lastName,
        "day": day,
        "month": month,
        "year": year,
        "mobileNumber": mobileNumber,
        "doB": doB,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "primaryMember": primaryMember,
        "membershipRegistrationNumber": membershipRegistrationNumber,
        "address": address,
        "divisionId": divisionId,
        "upazilaId": upazilaId,
        "districtId": districtId,
        "nid": nid,
        "bloodGroup": bloodGroup,
        "isActive": isActive,
        "note": note,
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "firstDoseDate": firstDoseDate,
        "secondDoseDate": secondDoseDate,
        "bosterDoseDate": bosterDoseDate,
        "heightFeet": heightFeet,
        "heightInches": heightInches,
        "weight": weight,
        "bmi": bmi,
        "bodyTemparature": bodyTemparature,
        "appearance": appearance,
        "anemia": anemia,
        "jaundice": jaundice,
        "dehydration": dehydration,
        "edema": edema,
        "cyanosis": cyanosis,
        "heart": heart,
        "lung": lung,
        "abdomen": abdomen,
        "rbsFbs": rbsFbs,
        "bloodPressureSystolic": bloodPressureSystolic,
        "bloodPressureDiastolic": bloodPressureDiastolic,
        "heartRate": heartRate,
        "pulseRate": pulseRate,
        "spO2": spO2,
        "isLatest": isLatest,
      };
}
