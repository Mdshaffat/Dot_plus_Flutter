class PhysicalStat {
  PhysicalStat({
    this.id,
    required this.patientId,
    this.heightFeet,
    this.heightInches,
    this.weight,
    this.bodyTemparature,
    this.appearance,
    this.anemia,
    this.jaundice,
    this.dehydration,
    this.edema,
    this.cyanosis,
    this.rbsFbs,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.pulseRate,
    this.spO2,
  });

  int? id;
  int patientId;
  int? heightFeet;
  int? heightInches;
  int? weight;
  String? bodyTemparature;
  String? appearance;
  String? anemia;
  String? jaundice;
  String? dehydration;
  String? edema;
  String? cyanosis;
  String? rbsFbs;
  String? bloodPressureSystolic;
  String? bloodPressureDiastolic;
  int? pulseRate;
  int? spO2;

  factory PhysicalStat.fromJson(Map<String, dynamic> json) => PhysicalStat(
        id: json['id'],
        patientId: json["patientId"],
        heightFeet: json["heightFeet"],
        heightInches: json["heightInches"],
        weight: json["weight"],
        bodyTemparature: json["bodyTemparature"],
        appearance: json["appearance"],
        anemia: json["anemia"],
        jaundice: json["jaundice"],
        dehydration: json["dehydration"],
        edema: json["edema"],
        cyanosis: json["cyanosis"],
        rbsFbs: json["rbsFbs"],
        bloodPressureSystolic: json["bloodPressureSystolic"],
        bloodPressureDiastolic: json["bloodPressureDiastolic"],
        pulseRate: json["pulseRate"],
        spO2: json["spO2"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        "patientId": patientId,
        "heightFeet": heightFeet,
        "heightInches": heightInches,
        "weight": weight,
        "bodyTemparature": bodyTemparature,
        "appearance": appearance,
        "anemia": anemia,
        "jaundice": jaundice,
        "dehydration": dehydration,
        "edema": edema,
        "cyanosis": cyanosis,
        "rbsFbs": rbsFbs,
        "bloodPressureSystolic": bloodPressureSystolic,
        "bloodPressureDiastolic": bloodPressureDiastolic,
        "pulseRate": pulseRate,
        "spO2": spO2,
      };
}
