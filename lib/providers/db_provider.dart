import 'dart:io';
import 'package:hospital_app/Models/diseaseAndMedicine/diagnosis.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/disease.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/diseaseCategory.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine_for_prescription.dart';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/division.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/patientAdd.dart';
import 'package:hospital_app/Models/physicalStatModel/physical_stat.dart';
import 'package:hospital_app/Models/prescription_model/prescription_dto.dart';
import 'package:hospital_app/Models/user.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/callinginfo.dart';
import '../Models/callinginfoofflinemodel.dart';
import '../Models/patientOfflineModel.dart';
import '../Models/upazila.dart';

class DBProvider {
  static const _databaseName = 'newdatabase6.db';
  static const _databaseVersion = 4;
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the tables
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path, version: _databaseVersion, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Hospital('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'branchId INTEGER'
          ')');
      await db.execute('CREATE TABLE Division('
          'id INTEGER PRIMARY KEY,'
          'name TEXT'
          ')');
      await db.execute('CREATE TABLE District('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'divisionId INTEGER'
          ')');
      await db.execute('CREATE TABLE Upazila('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'districtId INTEGER'
          ')');
      await db.execute('''
        CREATE TABLE Patient(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  hospitalId INTEGER NOT NULL,
                  branchId INTEGER NOT NULL,
                  firstName TEXT,
                  lastName TEXT,
                  day INTEGER,
                  month INTEGER,
                  year INTEGER,
                  mobileNumber TEXT,
                  doB DATETIME,
                  gender TEXT,
                  maritalStatus TEXT,
                  primaryMember BOOLEAN,
                  membershipRegistrationNumber TEXT,
                  address TEXT,
                  divisionId INTEGER,
                  upazilaId INTEGER,
                  districtId INTEGER,
                  nid TEXT,
                  bloodGroup TEXT,
                  isActive BOOLEAN,
                  note TEXT,
                  covidvaccine TEXT,
                  vaccineBrand TEXT,
                  vaccineDose TEXT,
                  firstDoseDate DATETIME,
                  secondDoseDate DATETIME,
                  bosterDoseDate DATETIME,
                  heightFeet INTEGER,
                  heightInches INTEGER,
                  weight INTEGER,
                  bodyTemparature TEXT,
                  appearance TEXT,
                  anemia TEXT,
                  jaundice TEXT,
                  dehydration TEXT,
                  edema TEXT,
                  cyanosis TEXT,
                  rbsFbs TEXT,
                  bloodPressureSystolic TEXT,
                  bloodPressureDiastolic TEXT,
                  pulseRate INTEGER,
                  spO2 INTEGER
                  )
          ''');
      await db.execute('''
        CREATE TABLE CallerInfo(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  patietnId INTEGER,
                  callerId TEXT,
                  receiverId TEXT,
                  receiverFirstName TEXT,
                  receiverLastName TEXT,
                  callingTime DATETIME,
                  status BOOLEAN
                  )
          ''');
      await db.execute('''
        CREATE TABLE User(
                  userId TEXT PRIMARY KEY,
                  firstName TEXT,
                  lastName TEXT,
                  phoneNumber TEXT
                  )
          ''');
      await db.execute('''
        CREATE TABLE Medicine(
                  id INTEGER PRIMARY KEY,
                  medicineType TEXT,
                  brandName TEXT,
                  genericName TEXT
                  )
          ''');
      await db.execute('''
        CREATE TABLE DiseaseCategory(
                  id INTEGER PRIMARY KEY,
                  name TEXT
                  )
          ''');
      await db.execute('''
        CREATE TABLE Disease(
                  id INTEGER PRIMARY KEY,
                  name TEXT,
                  diseasesCategoryId INTEGER
                  )
          ''');
      // Prescription Table
      await db.execute('''
        CREATE TABLE Prescription(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  patientId INTEGER,
                  hospitalId INTEGER,
                  branchId INTEGER,
                  doctorsObservation TEXT,
                  adviceTest TEXT,
                  oh TEXT,
                  systemicExamination TEXT,
                  historyOfPastIllness TEXT,
                  familyHistory TEXT,
                  allergicHistory TEXT,
                  nextVisit TEXT,
                  isTelimedicine BOOLEAN,
                  isAfternoon BOOLEAN,
                  note TEXT
                  )
          ''');
      //Diagnosis Table
      await db.execute('''
        CREATE TABLE Diagnosis(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  diseasesName TEXT,
                  diseasesId INTEGER,
                  diseasesCategoryId INTEGER,
                  prescriptionId INTEGER
                  )
          ''');
      // Medicine For Prescription Table
      await db.execute('''
        CREATE TABLE MedicineForPrescription(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  medicineId INTEGER,
                  medicineType TEXT,
                  brandName TEXT,
                  dose TEXT,
                  time TEXT,
                  comment TEXT,
                  prescriptionId INTEGER
                  )
          ''');
      await db.execute('''
        CREATE TABLE physicalStat(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  patientId INTEGER,
                  heightFeet INTEGER,
                  heightInches INTEGER,
                  weight INTEGER,
                  bodyTemparature TEXT,
                  appearance TEXT,
                  anemia TEXT,
                  jaundice TEXT,
                  dehydration TEXT,
                  edema TEXT,
                  cyanosis TEXT,
                  rbsFbs TEXT,
                  bloodPressureSystolic TEXT,
                  bloodPressureDiastolic TEXT,
                  pulseRate INTEGER,
                  spO2 INTEGER
                  )
          ''');
    });
  }

  //*************HOSPITAL_SECTION*************//

  // Insert hospital on database
  createHospital(Hospital newHospital) async {
    await deleteAllHospital();
    final db = await database;
    final res = await db.insert('Hospital', newHospital.toJson());
    return res;
  }

  // Delete all hospital
  Future<int> deleteAllHospital() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Hospital');

    return res;
  }

  //Get All Hospital
  Future getAllHospital() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Hospital");
    List<Hospital> list =
        res.isNotEmpty ? res.map((c) => Hospital.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getHospitalCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Hospital"));
    var count = res;

    return count;
  }
  //***************End Of Hospital *************//

  //*************DIVISION_SECTION*************//

  // Insert hospital on database
  createDivision(Division newDivision) async {
    await deleteAllDivision();
    final db = await database;
    final res = await db.insert('Division', newDivision.toJson());
    return res;
  }

  // Delete all hospital
  Future<int> deleteAllDivision() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Division');

    return res;
  }

  //Get All Hospital
  Future getAllDivision() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Division");
    List<Division> list =
        res.isNotEmpty ? res.map((c) => Division.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getDivisionCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Division"));
    var count = res;

    return count;
  }

  //***************End Of Division *************//

  //*************District_SECTION*************//

  createDistrict(District newDistrict) async {
    await deleteAllDistrict();
    final db = await database;
    final res = await db.insert('District', newDistrict.toJson());
    return res;
  }

  // Delete all hospital
  Future<int> deleteAllDistrict() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM District');

    return res;
  }

  Future getAllDistrict(int id) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM District WHERE divisionId=$id ORDER BY name ASC");
    List<District> list =
        res.isNotEmpty ? res.map((c) => District.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getDistrictCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  District"));
    var count = res;

    return count;
  }

  //***************End Of District *************//

  //*************UPAZILA_SECTION*************//

  // Insert hospital on database
  createUpazila(Upazila newUpazila) async {
    await deleteAllUpazila();
    final db = await database;
    final res = await db.insert('Upazila', newUpazila.toJson());
    return res;
  }

  // Delete all Upazila
  Future<int> deleteAllUpazila() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Upazila');

    return res;
  }

  //Get All Upazila
  Future getAllUpazila(int id) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Upazila WHERE districtId=$id ORDER BY name ASC");
    List<Upazila> list =
        res.isNotEmpty ? res.map((c) => Upazila.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getUpazilaCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Upazila"));
    var count = res;

    return count;
  }

  //***************End Of Upazila *************//

  // *********************** PATIENT **********************//

  createPatient(PatientAddModel newPatiet) async {
    final db = await database;
    final res = await db.insert('Patient', newPatiet.toJson());
    return res;
  }

  Future<int> deleteAllPatient() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Patient');

    return res;
  }

  Future getAllPatient() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Patient");
    List<PatientOfflineModel> list = res.isNotEmpty
        ? res.map((c) => PatientOfflineModel.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int?> getPatietnCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Patient"));
    var count = res;

    return count;
  }

  Future<int> deletePatient(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Patient WHERE id = $id');

    return res;
  }

  Future getPatient(int id) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Patient WHERE id = $id");
    List<PatientOfflineModel> list = res.isNotEmpty
        ? res.map((c) => PatientOfflineModel.fromJson(c)).toList()
        : [];

    return list;
  }

  //***************End Of Patient *************//

  // *********************** CallerInfo **********************//

  createCall(CallingInfoOffline newCall) async {
    final db = await database;
    final res = await db.insert('CallerInfo', newCall.toJson());
    return res;
  }

  Future<int> deleteAllCallinginfo() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM CallerInfo');

    return res;
  }

  Future getAllCallInfo() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM CallerInfo ORDER BY id DESC");
    List<CallingInfoOffline> list = res.isNotEmpty
        ? res.map((c) => CallingInfoOffline.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int> deleteSingleCalligInfo(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM CallerInfo WHERE id = $id');

    return res;
  }

  Future getSingleCallInfo(int id) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM CallerInfo WHERE id = $id");
    List<CallingInfoOffline> list = res.isNotEmpty
        ? res.map((c) => CallingInfoOffline.fromJson(c)).toList()
        : [];

    return list;
  }

  Future getUnSyncCallInfo() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT id,callerId,receiverId,patietnId,callingTime  FROM CallerInfo WHERE status = 0");
    List<CallingInfo> list =
        res.isNotEmpty ? res.map((c) => CallingInfo.fromJson(c)).toList() : [];

    return list;
  }

  updateCallStatus(int id) async {
    final db = await database;
    final res =
        await db.rawUpdate("UPDATE CallerInfo SET status=1 WHERE id=$id");
    return res;
  }

  //***************End Of CallerInfo *************//

  //*************User_SECTION*************//

  createUser(User newuser) async {
    await deleteAllUser();
    final db = await database;
    final res = await db.insert('User', newuser.toJson());
    return res;
  }

  // Delete all Upazila
  Future<int> deleteAllUser() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');

    return res;
  }

  //Get All Upazila
  Future getAllUser() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM User ORDER BY firstName ASC");
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getUserCount() async {
    final db = await database;
    final res =
        Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM  User"));
    var count = res;

    return count;
  }

  //***************End Of User *************//

  //*************Medicine_SECTION*************//

  createMedicine(Medicine newmedicine) async {
    await deleteAllMedicine();
    final db = await database;
    final res = await db.insert('Medicine', newmedicine.toJson());
    return res;
  }

  Future<int> deleteAllMedicine() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Medicine');

    return res;
  }

  Future<int?> getMedicineCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Medicine"));
    var count = res;

    return count;
  }

  Future searchMedicine(String? query) async {
    try {
      final db = await database;
      final res = await db.rawQuery(
          "SELECT * FROM Medicine WHERE brandName LIKE '$query%' LIMIT 20");
      List<Medicine> list =
          res.isNotEmpty ? res.map((c) => Medicine.fromJson(c)).toList() : [];

      return list;
    } catch (error) {
      print(error.toString());
    }
  }

  //***************End Of Medicine *************//

  //*************Disease_Category_SECTION*************//

  createDiseaseCategory(DiseaseCategory newdiseaseCategory) async {
    await deleteDiseaseCategory();
    final db = await database;
    final res = await db.insert('DiseaseCategory', newdiseaseCategory.toJson());
    return res;
  }

  Future<int> deleteDiseaseCategory() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM DiseaseCategory');

    return res;
  }

  Future getAllDiseaseCategory() async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM DiseaseCategory ORDER BY id ASC");
    List<DiseaseCategory> list = res.isNotEmpty
        ? res.map((c) => DiseaseCategory.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int?> getDiseaseCategoryCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  DiseaseCategory"));
    var count = res;

    return count;
  }

  //***************End Of Disease Category *************//

  //*************Disease_SECTION*************//

  createDisease(Disease newdisease) async {
    await deleteAllDisease();
    final db = await database;
    final res = await db.insert('Disease', newdisease.toJson());
    return res;
  }

  Future<int> deleteAllDisease() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Disease');

    return res;
  }

  Future getAllDisease() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Disease ORDER BY id ASC");
    List<Disease> list =
        res.isNotEmpty ? res.map((c) => Disease.fromJson(c)).toList() : [];

    return list;
  }

  Future getDiseasesAccordinToDiseaseCategory(int id) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Disease WHERE diseasesCategoryId=$id ORDER BY name ASC");
    List<Disease> list =
        res.isNotEmpty ? res.map((c) => Disease.fromJson(c)).toList() : [];
    return list;
  }

  Future<int?> getDiseaseCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Disease"));
    var count = res;

    return count;
  }

  //***************End Of User *************//

  // *********************** PRESCRIPTION **********************//

  createPrescription(PrescriptionDto newPrescription) async {
    final db = await database;
    final id = await db.insert('Prescription', newPrescription.toJson());
    return id;
  }

  Future<int> deleteAllPrescription() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Prescription');

    return res;
  }

  Future getAllPrescription() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Prescription");
    List<PrescriptionDto> list = res.isNotEmpty
        ? res.map((c) => PrescriptionDto.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int?> getPrescriptionCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Prescription"));
    var count = res;

    return count;
  }

  Future<int> deletePrescription(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Prescription WHERE id = $id');

    return res;
  }

  Future getPrescription(int id) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Prescription WHERE id = $id");
    List<PrescriptionDto> list = res.isNotEmpty
        ? res.map((c) => PrescriptionDto.fromJson(c)).toList()
        : [];

    return list;
  }

  //***************End Of PRESCRIPTION *************//

  // *********************** Medicine for prescription **********************//

  createMedicineForPrescription(newPrescription) async {
    final db = await database;
    final id = await db.insert('MedicineForPrescription', newPrescription);
    return id;
  }

  Future getAllMedicineForPrescription() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM MedicineForPrescription");
    List<MedicineForPrescription> list = res.isNotEmpty
        ? res.map((c) => MedicineForPrescription.fromJson(c)).toList()
        : [];

    return list;
  }

  Future getMedicineForPrescription(int id) async {
    final db = await database;
    final res = await db
        .rawQuery("SELECT * FROM MedicineForPrescription WHERE id = $id");
    List<MedicineForPrescription> list = res.isNotEmpty
        ? res.map((c) => MedicineForPrescription.fromJson(c)).toList()
        : [];

    return list;
  }

  Future getMedicineForPrescriptionByPrescriptionId(int prescriptionId) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM MedicineForPrescription WHERE prescriptionId = $prescriptionId");
    List<MedicineForPrescription> list = res.isNotEmpty
        ? res.map((c) => MedicineForPrescription.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int?> getMedicineForPrescriptionCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  MedicineForPrescription"));
    var count = res;

    return count;
  }

  Future<int> deleteMedicineForPrescription(int id) async {
    final db = await database;
    final res = await db
        .rawDelete('DELETE FROM MedicineForPrescription WHERE id = $id');

    return res;
  }

  Future<int> deleteAllMedicineForPrescription() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM MedicineForPrescription');

    return res;
  }

  Future<int> deleteMedicineForPrescriptionByPrescriptionId(
      int prescriptionId) async {
    final db = await database;
    final res = await db.rawDelete(
        'DELETE FROM MedicineForPrescription WHERE prescriptionId = $prescriptionId');

    return res;
  }

  //***************End Of MEDICINE FOR PRESCRIPTION *************//

  // *********************** Diagnosis **********************//

  createDiagnosis(newDiagnosis) async {
    final db = await database;
    final id = await db.insert('Diagnosis', newDiagnosis);
    return id;
  }

  Future<int> deleteAllDiagnosis() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Diagnosis');

    return res;
  }

  Future<int> deleteDiagnosisByPrescriptionId(int prescriptionId) async {
    final db = await database;
    final res = await db.rawDelete(
        'DELETE FROM Diagnosis WHERE prescriptionId = $prescriptionId');

    return res;
  }

  Future getAllDiagnosis() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Diagnosis");
    List<Diagnosis> list =
        res.isNotEmpty ? res.map((c) => Diagnosis.fromJson(c)).toList() : [];

    return list;
  }

  Future getDiagnosis(int id) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Diagnosis WHERE id = $id");
    List<Diagnosis> list =
        res.isNotEmpty ? res.map((c) => Diagnosis.fromJson(c)).toList() : [];

    return list;
  }

  Future getDiagnosisForPrescription(int prescriptionId) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Diagnosis WHERE prescriptionId = $prescriptionId");
    List<Diagnosis> list =
        res.isNotEmpty ? res.map((c) => Diagnosis.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getDiagnosisCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  Diagnosis"));
    var count = res;

    return count;
  }

  Future<int> deleteDiagnosis(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Diagnosis WHERE id = $id');

    return res;
  }

  //***************End Of Diagnosis *************//

  // *********************** Diagnosis **********************//

  createPhysicalStat(PhysicalStat newPhysicalStats) async {
    final db = await database;
    final id = await db.insert('physicalStat', newPhysicalStats.toJson());
    return id;
  }

  Future<int> deleteAllPhysicalStat() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM physicalStat');

    return res;
  }

  Future<int> deletePhysicalStatById(int id) async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM physicalStat WHERE id = $id');

    return res;
  }

  Future getAllPhysicalStat() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM physicalStat");
    List<PhysicalStat> list =
        res.isNotEmpty ? res.map((c) => PhysicalStat.fromJson(c)).toList() : [];

    return list;
  }

  Future<int?> getPhysicalStatCount() async {
    final db = await database;
    final res = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM  PhysicalStat"));
    var count = res;

    return count;
  }

  Future getPhysicalStatById(int id) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM PhysicalStat WHERE id = $id");
    List<PhysicalStat> list =
        res.isNotEmpty ? res.map((c) => PhysicalStat.fromJson(c)).toList() : [];

    return list;
  }

  //***************End Of Diagnosis *************//
}
