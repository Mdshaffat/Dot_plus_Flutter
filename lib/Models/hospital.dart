class Hospital {
  final int Id;
  final String? Name;
  final int? BranchId;
  const Hospital({required this.Id, this.Name, this.BranchId});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
        Id: json['id'], Name: json['name'], BranchId: json['branchId']);
  }

  Map<String, dynamic> toJson() =>
      {'id': Id, 'name': Name, 'branchId': BranchId};
}
