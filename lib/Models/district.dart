class District {
  final int Id;
  final String Name;
  const District({required this.Id, required this.Name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(Id: json['id'], Name: json['name']);
  }
  Map<String, dynamic> toJson() => {"id": Id, "name": Name};
}
