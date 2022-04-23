import 'dart:io';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/division.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/patientAdd.dart';
import 'package:hospital_app/Models/user.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/callinginfo.dart';
import '../Models/callinginfoofflinemodel.dart';
import '../Models/patientOfflineModel.dart';
import '../Models/upazila.dart';

class DBProvider {
  static const _databaseName = 'dot_plus_db_4.db';
  static const _databaseVersion = 2;
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
}
