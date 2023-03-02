import 'dart:convert';

GetPatientData getPatientDataFromJson(String str) =>
    GetPatientData.fromJson(json.decode(str));

String getPatientDataToJson(GetPatientData data) => json.encode(data.toJson());

class GetPatientData {
  GetPatientData({
    required this.id,
    required this.hospitalId,
    required this.hospitalName,
    this.firstName,
    this.lastName,
    this.doB,
    this.age,
    this.mobileNumber,
    this.gender,
    this.maritalStatus,
    this.tobacoHabit,
    this.primaryMember,
    this.membershipRegistrationNumber,
    this.address,
    this.divisionId,
    this.division,
    this.upazilaId,
    this.upazila,
    this.districtId,
    this.district,
    this.nid,
    this.bloodGroup,
    this.branchId,
    this.branchName,
    this.isActive,
    this.note,
    this.covidvaccine,
    this.vaccineBrand,
    this.vaccineDose,
    this.firstDoseDate,
    this.secondDoseDate,
    this.bosterDoseDate,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
    required this.physicalStat,
  });

  int id;
  int hospitalId;
  String hospitalName;
  String? firstName;
  String? lastName;
  String? doB;
  String? age;
  String? mobileNumber;
  String? gender;
  String? maritalStatus;
  String? tobacoHabit;
  bool? primaryMember;
  String? membershipRegistrationNumber;
  String? address;
  int? divisionId;
  String? division;
  int? upazilaId;
  String? upazila;
  int? districtId;
  String? district;
  String? nid;
  String? bloodGroup;
  int? branchId;
  String? branchName;
  bool? isActive;
  String? note;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? firstDoseDate;
  String? secondDoseDate;
  String? bosterDoseDate;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;
  List<PhysicalStat> physicalStat;

  factory GetPatientData.fromJson(Map<String, dynamic> json) => GetPatientData(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        doB: json["doB"],
        age: json["age"],
        mobileNumber: json["mobileNumber"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        tobacoHabit: json["tobacoHabit"],
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
        firstDoseDate: json["firstDoseDate"],
        secondDoseDate: json["secondDoseDate"],
        bosterDoseDate: json["bosterDoseDate"],
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        updatedOn: json["updatedOn"],
        updatedBy: json["updatedBy"],
        physicalStat: List<PhysicalStat>.from(
            json["physicalStat"].map((x) => PhysicalStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "firstName": firstName,
        "lastName": lastName,
        "doB": doB,
        "age": age,
        "mobileNumber": mobileNumber,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "tobacoHabit": tobacoHabit,
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
        "firstDoseDate": firstDoseDate,
        "secondDoseDate": secondDoseDate,
        "bosterDoseDate": bosterDoseDate,
        "createdOn": createdOn,
        "createdBy": createdBy,
        "updatedOn": updatedOn,
        "updatedBy": updatedBy,
        "physicalStat": List<dynamic>.from(physicalStat.map((x) => x.toJson())),
      };
}

class PhysicalStat {
  PhysicalStat({
    required this.id,
    required this.hospitalId,
    this.hospitalName,
    required this.patientId,
    this.patientFirstName,
    this.patientLastName,
    this.visitEntryId,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.heartRate,
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
    this.kub,
    this.rbsFbs,
    this.heightFeet,
    this.heightInches,
    this.weight,
    this.bmi,
    this.waist,
    this.hip,
    this.spO2,
    this.pulseRate,
    this.isLatest,
    this.createdOn,
    this.createdBy,
    this.editedOn,
    this.editedBy,
  });

  int id;
  int hospitalId;
  String? hospitalName;
  int patientId;
  String? patientFirstName;
  String? patientLastName;
  int? visitEntryId;
  String? bloodPressureSystolic;
  String? bloodPressureDiastolic;
  String? heartRate;
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
  String? kub;
  String? rbsFbs;
  int? heightFeet;
  int? heightInches;
  double? weight;
  double? bmi;
  String? waist;
  String? hip;
  double? spO2;
  double? pulseRate;
  bool? isLatest;
  String? createdOn;
  String? createdBy;
  String? editedOn;
  String? editedBy;

  factory PhysicalStat.fromJson(Map<String, dynamic> json) => PhysicalStat(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        patientId: json["patientId"],
        patientFirstName: json["patientFirstName"],
        patientLastName: json["patientLastName"],
        visitEntryId: json["visitEntryId"],
        bloodPressureSystolic: json["bloodPressureSystolic"],
        bloodPressureDiastolic: json["bloodPressureDiastolic"],
        heartRate: json["heartRate"],
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
        kub: json["kub"],
        rbsFbs: json["rbsFbs"],
        heightFeet: json["heightFeet"],
        heightInches: json["heightInches"],
        weight: json["weight"],
        bmi: json["bmi"],
        waist: json["waist"],
        hip: json["hip"],
        spO2: json["spO2"],
        pulseRate: json["pulseRate"],
        isLatest: json["isLatest"],
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        editedOn: json["editedOn"],
        editedBy: json["editedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "patientId": patientId,
        "patientFirstName": patientFirstName,
        "patientLastName": patientLastName,
        "visitEntryId": visitEntryId,
        "bloodPressureSystolic": bloodPressureSystolic,
        "bloodPressureDiastolic": bloodPressureDiastolic,
        "heartRate": heartRate,
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
        "kub": kub,
        "rbsFbs": rbsFbs,
        "heightFeet": heightFeet,
        "heightInches": heightInches,
        "weight": weight,
        "bmi": bmi,
        "waist": waist,
        "hip": hip,
        "spO2": spO2,
        "pulseRate": pulseRate,
        "isLatest": isLatest,
        "createdOn": createdOn,
        "createdBy": createdBy,
        "editedOn": editedOn,
        "editedBy": editedBy,
      };
}
