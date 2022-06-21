class Medicine {
  final int id;
  final String medicineType;
  final String brandName;
  final String genericName;
  const Medicine({
    required this.id,
    required this.medicineType,
    required this.brandName,
    required this.genericName,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        id: json['id'],
        medicineType: json['medicineType'],
        brandName: json['brandName'],
        genericName: json['genericName']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'medicineType': medicineType,
        'brandName': brandName,
        'genericName': genericName
      };
}
