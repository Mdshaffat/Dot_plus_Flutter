class DiseaseCategory {
  final int id;
  final String name;
  const DiseaseCategory({required this.id, required this.name});

  factory DiseaseCategory.fromJson(Map<String, dynamic> json) {
    return DiseaseCategory(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
