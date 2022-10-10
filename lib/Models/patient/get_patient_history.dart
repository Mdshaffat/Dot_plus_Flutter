import 'dart:convert';

PatientHistoryModel patientHistoryModelFromJson(String str) =>
    PatientHistoryModel.fromJson(json.decode(str));

String patientHistoryModelToJson(PatientHistoryModel data) =>
    json.encode(data.toJson());

class PatientHistoryModel {
  PatientHistoryModel({
    required this.patient,
    this.visitEntries,
    this.prescription,
    this.physicalState,
  });

  Patient patient;
  List<VisitEntry>? visitEntries;
  List<Prescription>? prescription;
  List<PhysicalStat>? physicalState;

  factory PatientHistoryModel.fromJson(Map<String, dynamic> json) =>
      PatientHistoryModel(
        patient: Patient.fromJson(json["patient"]),
        visitEntries: List<VisitEntry>.from(
            json["visitEntries"].map((x) => VisitEntry.fromJson(x))),
        prescription: List<Prescription>.from(
            json["prescription"].map((x) => Prescription.fromJson(x))),
        physicalState: List<PhysicalStat>.from(
            json["physicalState"].map((x) => PhysicalStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patient": patient.toJson(),
        "visitEntries":
            List<dynamic>.from(visitEntries!.map((x) => x.toJson())),
        "prescription":
            List<dynamic>.from(prescription!.map((x) => x.toJson())),
        "physicalState":
            List<dynamic>.from(physicalState!.map((x) => x.toJson())),
      };
}

class Patient {
  Patient({
    required this.id,
    this.hospitalId,
    this.hospitalName,
    this.firstName,
    this.lastName,
    this.doB,
    this.age,
    this.mobileNumber,
    this.gender,
    this.maritalStatus,
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
    this.physicalStat,
  });

  int id;
  int? hospitalId;
  String? hospitalName;
  String? firstName;
  String? lastName;
  String? doB;
  String? age;
  String? mobileNumber;
  String? gender;
  String? maritalStatus;
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
  List<PhysicalStat>? physicalStat;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
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
        "physicalStat":
            List<dynamic>.from(physicalStat!.map((x) => x.toJson())),
      };
}

class PhysicalStat {
  PhysicalStat({
    this.id,
    this.hospitalId,
    this.hospitalName,
    this.patientId,
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

  int? id;
  int? hospitalId;
  String? hospitalName;
  int? patientId;
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

class Prescription {
  Prescription({
    this.id,
    this.hospitalId,
    this.hospitalName,
    this.patientId,
    this.patientFirstName,
    this.patientLastName,
    this.patientBloodGroup,
    this.patientDob,
    this.patientAge,
    this.patientMobile,
    this.patientGender,
    this.medicineForPrescription,
    this.physicalStat,
    this.diagnosis,
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
    this.nextVisit,
    this.covidvaccine,
    this.vaccineBrand,
    this.vaccineDose,
    this.note,
    this.isTelimedicine,
    this.isAfternoon,
    this.createdOn,
    this.updatedOn,
  });

  int? id;
  int? hospitalId;
  String? hospitalName;
  int? patientId;
  String? patientFirstName;
  String? patientLastName;
  String? patientBloodGroup;
  String? patientDob;
  String? patientAge;
  String? patientMobile;
  String? patientGender;
  List<MedicineForPrescription>? medicineForPrescription;
  PhysicalStat? physicalStat;
  List<Diagnosis>? diagnosis;
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
  String? nextVisit;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? note;
  bool? isTelimedicine;
  bool? isAfternoon;
  String? createdOn;
  String? updatedOn;

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        patientId: json["patientId"],
        patientFirstName: json["patientFirstName"],
        patientLastName: json["patientLastName"],
        patientBloodGroup: json["patientBloodGroup"],
        patientDob: json["patientDob"],
        patientAge: json["patientAge"],
        patientMobile: json["patientMobile"],
        patientGender: json["patientGender"],
        medicineForPrescription: List<MedicineForPrescription>.from(
            json["medicineForPrescription"]
                .map((x) => MedicineForPrescription.fromJson(x))),
        physicalStat: PhysicalStat.fromJson(json["physicalStat"]),
        diagnosis: List<Diagnosis>.from(
            json["diagnosis"].map((x) => Diagnosis.fromJson(x))),
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
        nextVisit: json["nextVisit"],
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        note: json["note"],
        isTelimedicine: json["isTelimedicine"],
        isAfternoon: json["isAfternoon"],
        createdOn: json["createdOn"],
        updatedOn: json["updatedOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "patientId": patientId,
        "patientFirstName": patientFirstName,
        "patientLastName": patientLastName,
        "patientBloodGroup": patientBloodGroup,
        "patientDob": patientDob,
        "patientAge": patientAge,
        "patientMobile": patientMobile,
        "patientGender": patientGender,
        "medicineForPrescription":
            List<dynamic>.from(medicineForPrescription!.map((x) => x.toJson())),
        "physicalStat": physicalStat!.toJson(),
        "diagnosis": List<dynamic>.from(diagnosis!.map((x) => x.toJson())),
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
        "nextVisit": nextVisit,
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "note": note,
        "isTelimedicine": isTelimedicine,
        "isAfternoon": isAfternoon,
        "createdOn": createdOn,
        "updatedOn": updatedOn,
      };
}

class Diagnosis {
  Diagnosis({
    required this.id,
    this.patientId,
    this.patientFristName,
    this.patientLastName,
    this.prescriptionId,
    this.diseasesCategoryId,
    this.diseasesCategory,
    this.diseasesId,
    this.diseases,
    this.updatedBy,
    this.updatedAt,
  });

  int id;
  int? patientId;
  String? patientFristName;
  String? patientLastName;
  int? prescriptionId;
  int? diseasesCategoryId;
  String? diseasesCategory;
  int? diseasesId;
  Diseases? diseases;
  String? updatedBy;
  String? updatedAt;

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
        id: json["id"],
        patientId: json["patientId"],
        patientFristName: json["patientFristName"],
        patientLastName: json["patientLastName"],
        prescriptionId: json["prescriptionId"],
        diseasesCategoryId: json["diseasesCategoryId"],
        diseasesCategory: json["diseasesCategory"],
        diseasesId: json["diseasesId"],
        diseases: Diseases.fromJson(json["diseases"]),
        updatedBy: json["updatedBy"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "patientFristName": patientFristName,
        "patientLastName": patientLastName,
        "prescriptionId": prescriptionId,
        "diseasesCategoryId": diseasesCategoryId,
        "diseasesCategory": diseasesCategory,
        "diseasesId": diseasesId,
        "diseases": diseases!.toJson(),
        "updatedBy": updatedBy,
        "updatedAt": updatedAt,
      };
}

class Diseases {
  Diseases({
    this.id,
    this.name,
    this.isActive,
    this.diseasesCategoryId,
    this.diseasesCategory,
  });

  int? id;
  String? name;
  bool? isActive;
  int? diseasesCategoryId;
  DiseasesCategory? diseasesCategory;

  factory Diseases.fromJson(Map<String, dynamic> json) => Diseases(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        diseasesCategoryId: json["diseasesCategoryId"],
        diseasesCategory: DiseasesCategory.fromJson(json["diseasesCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
        "diseasesCategoryId": diseasesCategoryId,
        "diseasesCategory": diseasesCategory!.toJson(),
      };
}

class DiseasesCategory {
  DiseasesCategory({
    this.id,
    this.name,
    this.isActive,
  });

  int? id;
  String? name;
  bool? isActive;

  factory DiseasesCategory.fromJson(Map<String, dynamic> json) =>
      DiseasesCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
      };
}

class MedicineForPrescription {
  MedicineForPrescription({
    this.id,
    this.medicineId,
    this.medicineType,
    this.brandName,
    this.genericName,
    this.dose,
    this.time,
    this.comment,
  });

  int? id;
  int? medicineId;
  String? medicineType;
  String? brandName;
  String? genericName;
  String? dose;
  String? time;
  String? comment;

  factory MedicineForPrescription.fromJson(Map<String, dynamic> json) =>
      MedicineForPrescription(
        id: json["id"],
        medicineId: json["medicineId"],
        medicineType: json["medicineType"],
        brandName: json["brandName"],
        genericName: json["genericName"],
        dose: json["dose"],
        time: json["time"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "medicineId": medicineId,
        "medicineType": medicineType,
        "brandName": brandName,
        "genericName": genericName,
        "dose": dose,
        "time": time,
        "comment": comment,
      };
}

class VisitEntry {
  VisitEntry({
    this.id,
    this.hospitalId,
    this.hospitalName,
    this.date,
    this.patientId,
    this.patientFirstName,
    this.patientLastName,
    this.serial,
    this.status,
  });

  int? id;
  int? hospitalId;
  String? hospitalName;
  String? date;
  int? patientId;
  String? patientFirstName;
  String? patientLastName;
  int? serial;
  String? status;

  factory VisitEntry.fromJson(Map<String, dynamic> json) => VisitEntry(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        date: json["date"],
        patientId: json["patientId"],
        patientFirstName: json["patientFirstName"],
        patientLastName: json["patientLastName"],
        serial: json["serial"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "date": date,
        "patientId": patientId,
        "patientFirstName": patientFirstName,
        "patientLastName": patientLastName,
        "serial": serial,
        "status": status,
      };
}
