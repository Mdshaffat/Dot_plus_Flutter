class Upazila {
  final int Id;
  final String Name;
  final int? DistrictId;

  const Upazila({required this.Id, required this.Name, this.DistrictId});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
        Id: json['id'], Name: json['name'], DistrictId: json['districtId']);
  }
  Map<String, dynamic> toJson() =>
      {"id": Id, "name": Name, "districtId": DistrictId};
}
