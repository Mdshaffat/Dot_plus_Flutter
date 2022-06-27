class MedicineForPrescription {
  final int medicineId;
  final String? medicineType;
  final String? brandName;
  final String? dose;
  final String? time;
  final String? comment;

  const MedicineForPrescription({
    required this.medicineId,
    this.medicineType,
    this.brandName,
    this.dose,
    this.time,
    this.comment,
  });

  factory MedicineForPrescription.fromJson(Map<String, dynamic> json) {
    return MedicineForPrescription(
      medicineId: json['medicineId'],
      medicineType: json['medicineType'],
      brandName: json['brandName'],
      dose: json['dose'],
      time: json['time'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() => {
        'medicineId': medicineId,
        'medicineType': medicineType,
        'brandName': brandName,
        'dose': dose,
        'time': time,
        'comment': comment
      };
}
