// To parse this JSON data, do
//
//     final PrescriptionForList = PrescriptionForListFromJson(jsonString);

import 'dart:convert';

PrescriptionForList prescriptionForListFromJson(String str) =>
    PrescriptionForList.fromJson(json.decode(str));

String prescriptionForListToJson(PrescriptionForList data) =>
    json.encode(data.toJson());

class PrescriptionForList {
  PrescriptionForList({
    required this.pageIndex,
    required this.pageSize,
    required this.count,
    required this.data,
  });

  int pageIndex;
  int pageSize;
  int count;
  List<Prescription> data;

  factory PrescriptionForList.fromJson(Map<String, dynamic> json) =>
      PrescriptionForList(
        pageIndex: json["pageIndex"],
        pageSize: json["pageSize"],
        count: json["count"],
        data: List<Prescription>.from(
            json["data"].map((x) => Prescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Prescription {
  Prescription({
    required this.id,
    this.hospitalId,
    this.hospitalName,
    this.patientId,
    this.patientFirstName,
    this.patientLastName,
    this.patientBloodGroup,
    this.patientAge,
    this.patientMobile,
    this.patientGender,
    this.doctorId,
    this.doctorFirstName,
    this.doctorLastName,
    this.bmdcRegNo,
    this.optionalEmail,
    this.visitEntryId,
    this.doctorsObservation,
    this.adviceMedication,
    this.adviceTest,
    this.oh,
    this.mh,
    this.dx,
    this.systemicExamination,
    this.historyOfPastIllness,
    this.familyHistory,
    this.allergicHistory,
    this.covidvaccine,
    this.vaccineBrand,
    this.vaccineDose,
    this.note,
    this.isTelimedicine,
  });

  int? id;
  int? hospitalId;
  String? hospitalName;
  int? patientId;
  String? patientFirstName;
  String? patientLastName;
  String? patientBloodGroup;
  String? patientAge;
  String? patientMobile;
  String? patientGender;
  String? doctorId;
  String? doctorFirstName;
  String? doctorLastName;
  String? bmdcRegNo;
  String? optionalEmail;
  int? visitEntryId;
  String? doctorsObservation;
  String? adviceMedication;
  String? adviceTest;
  String? oh;
  String? mh;
  String? dx;
  String? systemicExamination;
  String? historyOfPastIllness;
  String? familyHistory;
  String? allergicHistory;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? note;
  bool? isTelimedicine;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        patientId: json["patientId"],
        patientFirstName: json["patientFirstName"],
        patientLastName: json["patientLastName"],
        patientBloodGroup: json["patientBloodGroup"],
        patientAge: json["patientAge"],
        patientMobile: json["patientMobile"],
        patientGender: json["patientGender"],
        doctorId: json["doctorId"],
        doctorFirstName: json["doctorFirstName"],
        doctorLastName: json["doctorLastName"],
        bmdcRegNo: json["bmdcRegNo"],
        optionalEmail: json["optionalEmail"],
        visitEntryId: json["visitEntryId"],
        doctorsObservation: json["doctorsObservation"],
        adviceMedication: json["adviceMedication"],
        adviceTest: json["adviceTest"],
        oh: json["oh"],
        mh: json["mh"],
        dx: json["dx"],
        systemicExamination: json["systemicExamination"],
        historyOfPastIllness: json["historyOfPastIllness"],
        familyHistory: json["familyHistory"],
        allergicHistory: json["allergicHistory"],
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        note: json["note"],
        isTelimedicine: json["isTelimedicine"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "patientId": patientId,
        "patientFirstName": patientFirstName,
        "patientLastName": patientLastName,
        "patientBloodGroup": patientBloodGroup,
        "patientAge": patientAge,
        "patientMobile": patientMobile,
        "patientGender": patientGender,
        "doctorId": doctorId,
        "doctorFirstName": doctorFirstName,
        "doctorLastName": doctorLastName,
        "bmdcRegNo": bmdcRegNo,
        "optionalEmail": optionalEmail,
        "visitEntryId": visitEntryId,
        "doctorsObservation": doctorsObservation,
        "adviceMedication": adviceMedication,
        "adviceTest": adviceTest,
        "oh": oh,
        "mh": mh,
        "dx": dx,
        "systemicExamination": systemicExamination,
        "historyOfPastIllness": historyOfPastIllness,
        "familyHistory": familyHistory,
        "allergicHistory": allergicHistory,
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "note": note,
        "isTelimedicine": isTelimedicine,
      };
}
