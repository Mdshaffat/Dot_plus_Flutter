class PrescriptionDto {
  int? id;
  int patientId;
  int hospitalId;
  int branchId;
  String? doctorsObservation;
  String? adviceTest;
  String? oh;
  String? systemicExamination;
  String? historyOfPastIllness;
  String? familyHistory;
  String? allergicHistory;
  String? nextVisit;
  int? isTelimedicine;
  String? note;
  int? isAfternoon;
  PrescriptionDto(
      {this.id,
      required this.patientId,
      required this.hospitalId,
      required this.branchId,
      this.doctorsObservation,
      this.adviceTest,
      this.oh,
      this.systemicExamination,
      this.historyOfPastIllness,
      this.familyHistory,
      this.allergicHistory,
      this.nextVisit,
      this.isTelimedicine,
      this.note,
      this.isAfternoon});

  factory PrescriptionDto.fromJson(Map<String, dynamic> json) {
    return PrescriptionDto(
        id: json['id'],
        patientId: json['patientId'],
        hospitalId: json['hospitalId'],
        branchId: json['branchId'],
        doctorsObservation: json['doctorsObservation'],
        adviceTest: json['adviceTest'],
        oh: json['oh'],
        systemicExamination: json['systemicExamination'],
        historyOfPastIllness: json['historyOfPastIllness'],
        familyHistory: json['familyHistory'],
        allergicHistory: json['allergicHistory'],
        nextVisit: json['nextVisit'],
        isTelimedicine: json['isTelimedicine'],
        isAfternoon: json['isAfternoon'],
        note: json['note']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'hospitalId': hospitalId,
        'branchId': branchId,
        'doctorsObservation': doctorsObservation,
        'adviceTest': adviceTest,
        'oh': oh,
        'systemicExamination': systemicExamination,
        'historyOfPastIllness': historyOfPastIllness,
        'familyHistory': familyHistory,
        'allergicHistory': allergicHistory,
        'nextVisit': nextVisit,
        'isTelimedicine': isTelimedicine,
        'isAfternoon': isAfternoon,
        'note': note
      };
}
