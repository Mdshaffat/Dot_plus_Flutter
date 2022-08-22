class PrescriptionOnline {
  PrescriptionOnline({
    required this.id,
    required this.hospitalId,
    this.hospitalName,
    required this.patientId,
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

  int id;
  int hospitalId;
  String? hospitalName;
  int patientId;
  String? patientFirstName;
  String? patientLastName;
  String? patientBloodGroup;
  DateTime? patientDob;
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
  DateTime? nextVisit;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? note;
  bool? isTelimedicine;
  bool? isAfternoon;
  DateTime? createdOn;
  DateTime? updatedOn;

  factory PrescriptionOnline.fromJson(Map<String?, dynamic> json) =>
      PrescriptionOnline(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        patientId: json["patientId"],
        patientFirstName: json["patientFirstName"],
        patientLastName: json["patientLastName"],
        patientBloodGroup: json["patientBloodGroup"],
        patientDob: DateTime?.tryParse(json["patientDob"]),
        patientAge: json["patientAge"],
        patientMobile: json["patientMobile"],
        patientGender: json["patientGender"],
        medicineForPrescription: (json["medicineForPrescription"] == null ||
                json["medicineForPrescription"] == 'null')
            ? null
            : List<MedicineForPrescription>.from(json["medicineForPrescription"]
                .map((x) => MedicineForPrescription.fromJson(x))),
        physicalStat:
            (json["physicalStat"] == null || json["physicalStat"] == 'null')
                ? null
                : PhysicalStat.fromJson(json["physicalStat"]),
        diagnosis: (json["diagnosis"] == null || json["diagnosis"] == 'null')
            ? null
            : List<Diagnosis>.from(
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
        nextVisit: (json["nextVisit"] == null || json["nextVisit"] == 'null')
            ? null
            : DateTime?.tryParse(json["nextVisit"]),
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        note: json["note"],
        isTelimedicine: json["isTelimedicine"],
        isAfternoon: json["isAfternoon"],
        createdOn: DateTime?.tryParse(json["createdOn"]),
        updatedOn: DateTime?.tryParse(json["updatedOn"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "patientId": patientId,
        "patientFirstName": patientFirstName,
        "patientLastName": patientLastName,
        "patientBloodGroup": patientBloodGroup,
        "patientDob": patientDob.toString(),
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
        "nextVisit": nextVisit.toString(),
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "note": note,
        "isTelimedicine": isTelimedicine,
        "isAfternoon": isAfternoon,
        "createdOn": createdOn.toString(),
        "updatedOn": updatedOn.toString(),
      };
}

class Diagnosis {
  Diagnosis({
    required this.id,
    required this.patientId,
    this.patientFristName,
    this.patientLastName,
    required this.prescriptionId,
    required this.diseasesCategoryId,
    this.diseasesCategory,
    required this.diseasesId,
    this.diseases,
    this.updatedBy,
    this.updatedAt,
  });

  int id;
  int patientId;
  String? patientFristName;
  String? patientLastName;
  int prescriptionId;
  int diseasesCategoryId;
  String? diseasesCategory;
  int diseasesId;
  Diseases? diseases;
  String? updatedBy;
  DateTime? updatedAt;

  factory Diagnosis.fromJson(Map<String?, dynamic> json) => Diagnosis(
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
        updatedAt: DateTime?.tryParse(json["updatedAt"]),
      );

  Map<String?, dynamic> toJson() => {
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
        "updatedAt": updatedAt.toString(),
      };
}

class Diseases {
  Diseases({
    required this.id,
    this.name,
    this.isActive,
    required this.diseasesCategoryId,
    this.diseasesCategory,
  });

  int id;
  String? name;
  bool? isActive;
  int diseasesCategoryId;
  DiseasesCategory? diseasesCategory;

  factory Diseases.fromJson(Map<String?, dynamic> json) => Diseases(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
        diseasesCategoryId: json["diseasesCategoryId"],
        diseasesCategory: DiseasesCategory.fromJson(json["diseasesCategory"]),
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
        "diseasesCategoryId": diseasesCategoryId,
        "diseasesCategory": diseasesCategory!.toJson(),
      };
}

class DiseasesCategory {
  DiseasesCategory({
    required this.id,
    this.name,
    this.isActive,
  });

  int id;
  String? name;
  bool? isActive;

  factory DiseasesCategory.fromJson(Map<String?, dynamic> json) =>
      DiseasesCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["isActive"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "name": name,
        "isActive": isActive,
      };
}

class MedicineForPrescription {
  MedicineForPrescription({
    required this.id,
    required this.medicineId,
    this.medicineType,
    this.brandName,
    this.genericName,
    this.dose,
    this.time,
    this.comment,
  });

  int id;
  int medicineId;
  String? medicineType;
  String? brandName;
  String? genericName;
  String? dose;
  String? time;
  String? comment;

  factory MedicineForPrescription.fromJson(Map<String?, dynamic> json) =>
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

  Map<String?, dynamic> toJson() => {
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
  DateTime? createdOn;
  String? createdBy;
  DateTime? editedOn;
  String? editedBy;

  factory PhysicalStat.fromJson(Map<String?, dynamic> json) => PhysicalStat(
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
        createdOn: DateTime?.tryParse(json["createdOn"]),
        createdBy: json["createdBy"],
        editedOn: DateTime?.tryParse(json["editedOn"]),
        editedBy: json["editedBy"],
      );

  Map<String?, dynamic> toJson() => {
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
        "createdOn": createdOn.toString(),
        "createdBy": createdBy,
        "editedOn": editedOn.toString(),
        "editedBy": editedBy,
      };
}
