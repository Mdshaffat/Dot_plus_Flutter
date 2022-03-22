class Branch {
  final int Id;
  final String BranchCode;
  final String Name;
  const Branch(
      {required this.Id, required this.Name, required this.BranchCode});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
        Id: json['id'], Name: json['name'], BranchCode: json['branchCode']);
  }
}
