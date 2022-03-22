class Upazila {
  final int Id;
  final String Name;
  const Upazila({required this.Id, required this.Name});

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(Id: json['id'], Name: json['name']);
  }
}
