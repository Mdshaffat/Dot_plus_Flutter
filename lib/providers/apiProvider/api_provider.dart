import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/Report/service_count.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/disease.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/diseaseCategory.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine.dart';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/division.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/upazila.dart';
import 'package:hospital_app/Models/user.dart';
import '../../Models/PatientSearch/search_patient.dart';
import '../db_provider.dart';

import 'package:http/http.dart' as http;

class ApiProvider {
  Future getAllHospitals() async {
    try {
      Response response = await Dio().get(HOSPITALURI);

      return (response.data as List).map((hospital) {
        print('Inserting $hospital');
        DBProvider.db.createHospital(Hospital.fromJson(hospital));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllDivision() async {
    try {
      Response response = await Dio().get(DIVISIONURI);

      return (response.data as List).map((division) {
        print('Inserting $division');
        DBProvider.db.createDivision(Division.fromJson(division));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllDistrict() async {
    try {
      Response response = await Dio().get(ALLDISTRICTURI);

      return (response.data as List).map((district) {
        print('Inserting $district');
        DBProvider.db.createDistrict(District.fromJson(district));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllUpazila() async {
    try {
      Response response = await Dio().get(ALLUPAZILAURI);

      return (response.data as List).map((upazila) {
        print('Inserting $upazila');
        DBProvider.db.createUpazila(Upazila.fromJson(upazila));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllUser() async {
    try {
      Response response = await Dio().get(USERS);

      return (response.data as List).map((user) {
        print('Inserting $user');
        DBProvider.db.createUser(User.fromJson(user));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllMedicine() async {
    try {
      Response response = await Dio().get(MEDICINEURI);
      print(response.toString());
      return (response.data as List).map((med) {
        print('Inserting $med');
        DBProvider.db.createMedicine(Medicine.fromJson(med));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllDiseaseCategory() async {
    try {
      Response response = await Dio().get(DISEASECATEGORYURI);

      return (response.data as List).map((discat) {
        print('Inserting $discat');
        DBProvider.db.createDiseaseCategory(DiseaseCategory.fromJson(discat));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  Future getAllDisease() async {
    try {
      Response response = await Dio().get(DISEASEURI);

      return (response.data as List).map((dis) {
        print('Inserting $dis');
        DBProvider.db.createDisease(Disease.fromJson(dis));
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  //searchPatient

  Future getSearchedPatient(String search) async {
    try {
      Response response =
          await Dio().get(PATIENTSEARCHURI + '?searchString=$search');
      List<SearchPatient> patients = (response.data as List)
          .map((e) => SearchPatient.fromJson(e))
          .toList();
      return patients;
    } catch (error) {
      rethrow;
    }
  }

  Future getPatientCount(String token) async {
    try {
      final baseresponse = await http.get(Uri.parse(PATIENTCOUNT), headers: {
        "Authorization": 'Bearer $token',
      });
      Map<String, dynamic> response = jsonDecode(baseresponse.body);
      NameWithCount patients = NameWithCount.fromJson(response);
      return patients;
    } catch (error) {
      rethrow;
    }
  }

  Future getPrescriptionCount(String token) async {
    try {
      final baseresponse =
          await http.get(Uri.parse(PRESCRIPTIONCOUNT), headers: {
        "Authorization": 'Bearer $token',
      });
      Map<String, dynamic> response = jsonDecode(baseresponse.body);
      NameWithCount patients = NameWithCount.fromJson(response);
      return patients;
    } catch (error) {
      rethrow;
    }
  }
}
