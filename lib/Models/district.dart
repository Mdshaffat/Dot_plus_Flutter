class District {
  final int Id;
  final String Name;
  final int? DivisionId;
  const District({required this.Id, required this.Name, this.DivisionId});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        Id: json['id'], Name: json['name'], DivisionId: json['divisionId']);
  }
  Map<String, dynamic> toJson() =>
      {"id": Id, "name": Name, "divisionId": DivisionId};
}
