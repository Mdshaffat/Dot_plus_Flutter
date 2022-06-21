class Disease {
  final int id;
  final String name;
  final int diseasesCategoryId;
  const Disease(
      {required this.id, required this.name, required this.diseasesCategoryId});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
      diseasesCategoryId: json['diseasesCategoryId'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'diseasesCategoryId': diseasesCategoryId};
}
