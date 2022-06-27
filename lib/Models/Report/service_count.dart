class NameWithCount {
  final String? name;
  final int? patientCount;
  const NameWithCount({this.name, this.patientCount});

  factory NameWithCount.fromJson(Map<String, dynamic> json) {
    return NameWithCount(
        name: json['name'], patientCount: json['patientCount']);
  }
}
