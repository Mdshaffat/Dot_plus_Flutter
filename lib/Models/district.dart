class District {
  final int id;
  final String name;
  final int? divisionId;
  const District({required this.id, required this.name, this.divisionId});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        id: json['id'], name: json['name'], divisionId: json['divisionId']);
  }
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "divisionId": divisionId};
}
