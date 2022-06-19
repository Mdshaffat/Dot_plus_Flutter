class Upazila {
  final int id;
  final String name;
  final int? districtId;

  const Upazila({required this.id, required this.name, this.districtId});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
        id: json['id'], name: json['name'], districtId: json['districtId']);
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "districtId": districtId};
}
