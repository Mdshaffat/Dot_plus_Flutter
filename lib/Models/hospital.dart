class Hospital {
  final int id;
  final String? name;
  final int? branchId;
  const Hospital({required this.id, this.name, this.branchId});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        id: json['id'], name: json['name'], branchId: json['branchId']);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'branchId': branchId};
}
