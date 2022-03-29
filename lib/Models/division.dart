class Division {
  final int Id;
  final String Name;
  const Division({required this.Id, required this.Name});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(Id: json['id'], Name: json['name']);
  }
  Map<String, dynamic> toJson() => {"id": Id, "name": Name};
}
