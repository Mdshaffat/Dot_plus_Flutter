class Diagnosis {
  //final int id;
  final String diseasesName;
  final int diseasesId;
  final int diseasesCategoryId;
  const Diagnosis(
      {
      //required this.id,
      required this.diseasesName,
      required this.diseasesId,
      required this.diseasesCategoryId});

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      //id: json['id'],
      diseasesName: json['diseasesName'],
      diseasesId: json['diseasesId'],
      diseasesCategoryId: json['diseasesCategoryId'],
    );
  }

  Map<String, dynamic> toJson() => {
        //'id': id,
        'diseasesName': diseasesName,
        'diseasesId': diseasesId,
        'diseasesCategoryId': diseasesCategoryId
      };
}
