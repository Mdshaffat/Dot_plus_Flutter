class Branch {
  final int id;
  final String branchCode;
  final String name;
  const Branch(
      {required this.id, required this.name, required this.branchCode});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
        id: json['id'], name: json['name'], branchCode: json['branchCode']);
  }
}
