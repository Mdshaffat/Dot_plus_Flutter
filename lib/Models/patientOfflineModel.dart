import 'dart:convert';

PatientOfflineModel patientOfflineModelFromJson(String str) =>
    PatientOfflineModel.fromJson(json.decode(str));

String patientOfflineModelToJson(PatientOfflineModel data) =>
    json.encode(data.toJson());

class PatientOfflineModel {
  PatientOfflineModel({
    required this.id,
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
    this.tobacoHabit,
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
    this.bodyTemparature,
    this.appearance,
    this.anemia,
    this.jaundice,
    this.dehydration,
    this.edema,
    this.cyanosis,
    this.rbsFbs,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.pulseRate,
    this.spO2,
  });

  int id;
  int hospitalId;
  int branchId;
  String? firstName;
  String? lastName;
  int? day;
  int? month;
  int? year;
  String? mobileNumber;
  String? doB;
  String? gender;
  String? maritalStatus;
  String? tobacoHabit;
  int? primaryMember;
  String? membershipRegistrationNumber;
  String? address;
  int? divisionId;
  int? upazilaId;
  int? districtId;
  String? nid;
  String? bloodGroup;
  int? isActive;
  String? note;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? firstDoseDate;
  String? secondDoseDate;
  String? bosterDoseDate;
  int? heightFeet;
  int? heightInches;
  int? weight;
  String? bodyTemparature;
  String? appearance;
  String? anemia;
  String? jaundice;
  String? dehydration;
  String? edema;
  String? cyanosis;
  String? rbsFbs;
  String? bloodPressureSystolic;
  String? bloodPressureDiastolic;
  int? pulseRate;
  int? spO2;

  factory PatientOfflineModel.fromJson(Map<String, dynamic> json) =>
      PatientOfflineModel(
        id: json["id"],
        hospitalId: json["hospitalId"],
        branchId: json["branchId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        mobileNumber: json["mobileNumber"],
        doB: json["doB"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        tobacoHabit: json["tobacoHabit"],
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
        firstDoseDate: json["firstDoseDate"],
        secondDoseDate: json["secondDoseDate"],
        bosterDoseDate: json["bosterDoseDate"],
        heightFeet: json["heightFeet"],
        heightInches: json["heightInches"],
        weight: json["weight"],
        bodyTemparature: json["bodyTemparature"],
        appearance: json["appearance"],
        anemia: json["anemia"],
        jaundice: json["jaundice"],
        dehydration: json["dehydration"],
        edema: json["edema"],
        cyanosis: json["cyanosis"],
        rbsFbs: json["rbsFbs"],
        bloodPressureSystolic: json["bloodPressureSystolic"],
        bloodPressureDiastolic: json["bloodPressureDiastolic"],
        pulseRate: json["pulseRate"],
        spO2: json["spO2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "tobacoHabit": tobacoHabit,
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
        "bodyTemparature": bodyTemparature,
        "appearance": appearance,
        "anemia": anemia,
        "jaundice": jaundice,
        "dehydration": dehydration,
        "edema": edema,
        "cyanosis": cyanosis,
        "rbsFbs": rbsFbs,
        "bloodPressureSystolic": bloodPressureSystolic,
        "bloodPressureDiastolic": bloodPressureDiastolic,
        "pulseRate": pulseRate,
        "spO2": spO2,
      };
}
