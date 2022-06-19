class Division {
  final int id;
  final String name;
  const Division({required this.id, required this.name});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(id: json['id'], name: json['name']);
  }
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
