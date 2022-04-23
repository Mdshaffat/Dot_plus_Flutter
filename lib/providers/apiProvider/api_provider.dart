import 'package:dio/dio.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/division.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/upazila.dart';
import 'package:hospital_app/Models/user.dart';
import '../db_provider.dart';

class ApiProvider {
  Future getAllHospitals() async {
    Response response = await Dio().get(HOSPITALURI);

    return (response.data as List).map((hospital) {
      print('Inserting $hospital');
      DBProvider.db.createHospital(Hospital.fromJson(hospital));
    }).toList();
  }

  Future getAllDivision() async {
    Response response = await Dio().get(DIVISIONURI);

    return (response.data as List).map((division) {
      print('Inserting $division');
      DBProvider.db.createDivision(Division.fromJson(division));
    }).toList();
  }

  Future getAllDistrict() async {
    Response response = await Dio().get(ALLDISTRICTURI);

    return (response.data as List).map((district) {
      print('Inserting $district');
      DBProvider.db.createDistrict(District.fromJson(district));
    }).toList();
  }

  Future getAllUpazila() async {
    Response response = await Dio().get(ALLUPAZILAURI);

    return (response.data as List).map((upazila) {
      print('Inserting $upazila');
      DBProvider.db.createUpazila(Upazila.fromJson(upazila));
    }).toList();
  }

  Future getAllUser() async {
    Response response = await Dio().get(USERS);

    return (response.data as List).map((user) {
      print('Inserting $user');
      DBProvider.db.createUser(User.fromJson(user));
    }).toList();
  }
}
