class GetPatientForEdit {
  GetPatientForEdit({
    required this.id,
    required this.hospitalId,
    required this.hospitalName,
    this.firstName,
    this.lastName,
    this.doB,
    this.age,
    this.mobileNumber,
    this.gender,
    this.maritalStatus,
    this.tobacoHabit,
    this.primaryMember,
    this.membershipRegistrationNumber,
    this.address,
    this.divisionId,
    this.division,
    this.upazilaId,
    this.upazila,
    this.districtId,
    this.district,
    this.nid,
    this.bloodGroup,
    this.branchId,
    this.branchName,
    this.isActive,
    this.note,
    this.covidvaccine,
    this.vaccineBrand,
    this.vaccineDose,
    this.firstDoseDate,
    this.secondDoseDate,
    this.bosterDoseDate,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
  });

  int id;
  int hospitalId;
  String hospitalName;
  String? firstName;
  String? lastName;
  String? doB;
  String? age;
  String? mobileNumber;
  String? gender;
  String? maritalStatus;
  String? tobacoHabit;
  bool? primaryMember;
  String? membershipRegistrationNumber;
  String? address;
  int? divisionId;
  String? division;
  int? upazilaId;
  String? upazila;
  int? districtId;
  String? district;
  String? nid;
  String? bloodGroup;
  int? branchId;
  String? branchName;
  bool? isActive;
  String? note;
  String? covidvaccine;
  String? vaccineBrand;
  String? vaccineDose;
  String? firstDoseDate;
  String? secondDoseDate;
  String? bosterDoseDate;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;

  factory GetPatientForEdit.fromJson(Map<String, dynamic> json) =>
      GetPatientForEdit(
        id: json["id"],
        hospitalId: json["hospitalId"],
        hospitalName: json["hospitalName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        doB: json["doB"],
        age: json["age"],
        mobileNumber: json["mobileNumber"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        tobacoHabit: json["tobacoHabit"],
        primaryMember: json["primaryMember"],
        membershipRegistrationNumber: json["membershipRegistrationNumber"],
        address: json["address"],
        divisionId: json["divisionId"],
        division: json["division"],
        upazilaId: json["upazilaId"],
        upazila: json["upazila"],
        districtId: json["districtId"],
        district: json["district"],
        nid: json["nid"],
        bloodGroup: json["bloodGroup"],
        branchId: json["branchId"],
        branchName: json["branchName"],
        isActive: json["isActive"],
        note: json["note"],
        covidvaccine: json["covidvaccine"],
        vaccineBrand: json["vaccineBrand"],
        vaccineDose: json["vaccineDose"],
        firstDoseDate: json["firstDoseDate"],
        secondDoseDate: json["secondDoseDate"],
        bosterDoseDate: json["bosterDoseDate"],
        createdOn: json["createdOn"],
        createdBy: json["createdBy"],
        updatedOn: json["updatedOn"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
        "firstName": firstName,
        "lastName": lastName,
        "doB": doB,
        "age": age,
        "mobileNumber": mobileNumber,
        "gender": gender,
        "maritalStatus": maritalStatus,
        "tobacoHabit": tobacoHabit,
        "primaryMember": primaryMember,
        "membershipRegistrationNumber": membershipRegistrationNumber,
        "address": address,
        "divisionId": divisionId,
        "division": division,
        "upazilaId": upazilaId,
        "upazila": upazila,
        "districtId": districtId,
        "district": district,
        "nid": nid,
        "bloodGroup": bloodGroup,
        "branchId": branchId,
        "branchName": branchName,
        "isActive": isActive,
        "note": note,
        "covidvaccine": covidvaccine,
        "vaccineBrand": vaccineBrand,
        "vaccineDose": vaccineDose,
        "firstDoseDate": firstDoseDate,
        "secondDoseDate": secondDoseDate,
        "bosterDoseDate": bosterDoseDate,
        "createdOn": createdOn,
        "createdBy": createdBy,
        "updatedOn": updatedOn,
        "updatedBy": updatedBy,
      };
}
