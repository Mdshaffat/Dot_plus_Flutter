import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hospital_app/Models/patient/get_patient_for_edit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/Models/patientOfflineModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../API/api.dart';
import '../../../Models/district.dart';
import '../../../Models/division.dart';
import '../../../Models/hospital.dart';
import '../../../Models/patientAdd.dart';
import '../../../Models/upazila.dart';
import '../../../Models/vaccine.dart';
import '../../../providers/db_provider.dart';
import '../../../widgets/RoundedButton.dart';
import '../patientAdd.dart';

class PatientOnlineEditFromTable extends StatefulWidget {
  final int id;
  const PatientOnlineEditFromTable({Key? key, required this.id})
      : super(key: key);

  @override
  State<PatientOnlineEditFromTable> createState() =>
      _PatientOnlineEditFromTableState();
}

class _PatientOnlineEditFromTableState
    extends State<PatientOnlineEditFromTable> {
  int? id;
  int? patientId;
  final _formKey = GlobalKey<FormState>();
  //

  List<SmokingHabit> _smokinghabit = [
    SmokingHabit(id: '1', name: 'Smoker'),
    SmokingHabit(id: '0', name: 'Non Smoker')
  ];
  List<Hospital> _hospitals = [];
  List<Division> _divisions = [];
  List<District> _districts = [];
  List<Upazila> _upazilas = [];
  DBProvider? dbProvider;

  NewVaccine vaccine = NewVaccine();
  bool isLoading = false;
  // late String email, password;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _membershipRegistrationNumberController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  Hospital? hospitalValue;
  int? hospitalDropdownValue;
  int? branchDropdownValue;
  int? divisionDropdownValue;
  int? districtDropdownValue;
  int? upazilaDropdownValue;
  String? genderDropdownValue;
  String? tobacoHabitDropdown;
  bool isActive = true;
  DateTime? dateOfBirth;
  String? meritalStatusValue;
  String? bloodGroupValue;
  int? covidVaccine;
  int? vaccineBrand;
  int? vaccineDose;
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  DateTime? bosterDoseDate;
  bool primaryMember = false;

  var myFormat = DateFormat('d-MM-yyyy');

  GetPatientForEdit patient =
      GetPatientForEdit(id: 0, hospitalId: 0, hospitalName: "0");

  //
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    fetchHospitals();
    fetchDivision();

    pathcValue(widget.id);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _nidController.dispose();
    _mobilenumberController.dispose();
    _noteController.dispose();
    _membershipRegistrationNumberController.dispose();
  }

  getData(int? id) async {
    setState(() {
      isLoading = true;
    });
    // if id == null
    if (id == null || id == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    // getting data
    try {
      Response response = await Dio().get(PATIENTURI + "/patientWithVital/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        patient = GetPatientForEdit.fromJson(response.data);
        setState(() {
          isLoading = false;
        });
      }
    } catch (data) {
      setState(() {
        //
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });

    // End Of Data
  }

  pathcValue(patientId) async {
    setState(() {
      isLoading = true;
    });
    await getData(patientId);

    if (patient.id == 0) {
      return;
    }

    var patientPatch = patient;
    if (patientPatch.divisionId != null || patientPatch.divisionId != 0) {
      await fetchDistrict(patientPatch.divisionId);
      await fetchUpazila(patientPatch.districtId);
    }

    var newHospital = Hospital(
        id: patientPatch.hospitalId,
        name: patientPatch.hospitalName,
        branchId: patientPatch.branchId);
    _hospitals.add(newHospital);

    id = patientPatch.id;
    _firstNameController.text = patientPatch.firstName ?? '';
    _lastNameController.text = patientPatch.lastName ?? '';
    _addressController.text = patientPatch.address ?? '';
    _nidController.text = patientPatch.nid ?? '';
    _mobilenumberController.text = patientPatch.mobileNumber ?? '';
    _noteController.text = patientPatch.note ?? '';
    _membershipRegistrationNumberController.text =
        patientPatch.membershipRegistrationNumber ?? '';

    hospitalDropdownValue = patientPatch.hospitalId;
    hospitalValue = newHospital;
    branchDropdownValue = patientPatch.branchId;

    if (patientPatch.divisionId != null && patientPatch.divisionId != 0) {
      divisionDropdownValue = patientPatch.divisionId;

      if (patientPatch.districtId != null && patientPatch.districtId != 0) {
        districtDropdownValue = patientPatch.districtId;
      }
      if (patientPatch.upazilaId != null && patientPatch.upazilaId != 0) {
        upazilaDropdownValue = patientPatch.upazilaId;
      }
    }
    //genderDropdownValue = patientPatch.gender;
    tobacoHabitDropdown = patientPatch.tobacoHabit;
    isActive = patientPatch.isActive ?? false;
    dateOfBirth = patientPatch.doB == null
        ? null
        : DateTime.parse(patientPatch.doB.toString());

    //meritalStatusValue = patientPatch.maritalStatus;
    //bloodGroupValue = patientPatch.bloodGroup;
    covidVaccine = (patientPatch.covidvaccine == null ||
            patientPatch.covidvaccine == 'null')
        ? null
        : int.parse(patientPatch.covidvaccine.toString());
    vaccineBrand = (patientPatch.vaccineBrand == null ||
            patientPatch.vaccineBrand == 'null')
        ? null
        : int.parse(patientPatch.vaccineBrand.toString());
    vaccineDose =
        (patientPatch.vaccineDose == null || patientPatch.vaccineDose == 'null')
            ? null
            : int.parse(patientPatch.vaccineDose.toString());
    firstDoseDate = patientPatch.firstDoseDate == null
        ? null
        : DateTime.parse(patientPatch.firstDoseDate.toString());
    secondDoseDate = patientPatch.secondDoseDate == null
        ? null
        : DateTime.parse(patientPatch.secondDoseDate.toString());
    bosterDoseDate = patientPatch.bosterDoseDate == null
        ? null
        : DateTime.parse(patientPatch.bosterDoseDate.toString());
    primaryMember = patientPatch.primaryMember ?? false;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != dateOfBirth) {
      setState(() {
        dateOfBirth = pickedDate;
      });
    }
  }

  Future<void> _selectDateForFirstDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != firstDoseDate) {
      setState(() {
        firstDoseDate = pickedDate;
      });
    }
  }

  Future<void> _selectDateForSecondDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != secondDoseDate) {
      setState(() {
        secondDoseDate = pickedDate;
      });
    }
  }

  Future<void> _selectDateForBosterDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != bosterDoseDate) {
      setState(() {
        bosterDoseDate = pickedDate;
      });
    }
  }

  // fatch Hospital
  fetchHospitals() async {
    List<Hospital> hospitals = [];
    // final response = await http.get(Uri.parse(HOSPITALURI));
    List<Hospital> totalHospital = await dbProvider?.getAllHospital();
    if (totalHospital.length > 1) {
      setState(() {
        _hospitals = totalHospital;
      });
    } else {
      _hospitals = [];
    }
  }

  fetchDivision() async {
    //List<Division> divisions = [];
    divisionDropdownValue = null;
    districtDropdownValue = null;
    upazilaDropdownValue = null;
    _divisions = [];
    _districts = [];
    _upazilas = [];
    // final response = await http.get(Uri.parse(DIVISIONURI));

    List<Division> totalDivision = await dbProvider?.getAllDivision();
    if (totalDivision.length > 1) {
      setState(() {
        _divisions = totalDivision;
      });
    } else {
      _divisions = [];
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //throw Exception('Failed to load division');
    }
  }

  fetchDistrict(id) async {
    districtDropdownValue = null;
    upazilaDropdownValue = null;
    _districts = [];
    _upazilas = [];
    //List<District> district = [];
    // final response = await http.get(Uri.parse(DISTRICTURI + id.toString()));
    List<District> totalDistrict = await dbProvider?.getAllDistrict(id);
    if (totalDistrict.isNotEmpty) {
      setState(() {
        _districts = totalDistrict;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      _districts = [];
      //throw Exception('Failed to load album');
    }
  }

  fetchUpazila(id) async {
    upazilaDropdownValue = null;
    //List<Upazila> upazila = [];
    // final response = await http.get(Uri.parse(UPAZILAURI + id.toString()));
    List<Upazila> totalUpazila = await dbProvider?.getAllUpazila(id);
    if (totalUpazila.isNotEmpty) {
      setState(() {
        _upazilas = totalUpazila;
      });
    } else {
      _upazilas = [];
      // throw Exception('Failed to load Upazila');
    }
  }

  updatePatient() async {
    setState(() {
      isLoading = true;
    });

    try {
      var data = jsonEncode({
        'id': id,
        'hospitalId': hospitalDropdownValue,
        'branchId': branchDropdownValue,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'mobileNumber': _mobilenumberController.text,
        'doB': dateOfBirth.toString(),
        'gender': genderDropdownValue,
        'maritalStatus': meritalStatusValue,
        'tobacoHabit': tobacoHabitDropdown,
        'primaryMember': primaryMember,
        'membershipRegistrationNumber':
            _membershipRegistrationNumberController.text,
        'address': _addressController.text,
        'divisionId': divisionDropdownValue,
        'upazilaId': upazilaDropdownValue,
        'districtId': districtDropdownValue,
        'nid': _nidController.text,
        'bloodGroup': bloodGroupValue,
        'isActive': isActive,
        'note': _noteController.text,
        'covidvaccine': covidVaccine,
        'vaccineBrand': vaccineBrand,
        'vaccineDose': vaccineDose,
        'firstDoseDate':
            firstDoseDate != null ? firstDoseDate.toString() : firstDoseDate,
        'secondDoseDate':
            secondDoseDate != null ? secondDoseDate.toString() : secondDoseDate,
        'bosterDoseDate':
            bosterDoseDate != null ? bosterDoseDate.toString() : bosterDoseDate,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString("token");
      if (token != null) {
        final response = await http.put(Uri.parse(PATIENTURI),
            headers: {
              "Accept": "application/json",
              "content-type": "application/json",
              "Authorization": 'Bearer $token',
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));
        if (response.statusCode == 200) {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          if (resposne.isNotEmpty) {
            scaffoldMessenger
                .showSnackBar(const SnackBar(content: Text("Success")));
            Navigator.pushReplacementNamed(context, "/patientlist");
          }
        } else {
          scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text("Something wrong to update")));
        }
      }
    } catch (val) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Something wrong to update")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  updatePatientToSqlte(
    firstName,
    lastName,
    hospitalId,
    branchId,
    address,
    divisionId,
    districtId,
    upazilaId,
    nid,
    mobileNumber,
    gender,
    day,
    month,
    year,
    dob,
    maritalStatus,
    bloodGroup,
    covidVaccine,
    vaccineBrand,
    vaccineDose,
    firstDoseDate,
    secondDoseDate,
    bosterDoseDate,
    note,
    primaryMember,
    membershipRegistrationNumber,
    isActive,
  ) async {
    if (id == null) {
      PatientAddModel newPatient = PatientAddModel(
        hospitalId: hospitalId,
        branchId: branchId,
        firstName: firstName,
        lastName: lastName,
        day: day,
        month: month,
        year: year,
        mobileNumber: mobileNumber,
        doB: dob,
        // != null ? DateTime.parse(dob) : null,
        gender: gender,
        maritalStatus: maritalStatus,
        primaryMember: primaryMember,
        membershipRegistrationNumber: membershipRegistrationNumber,
        address: address,
        divisionId: divisionId,
        upazilaId: upazilaId,
        districtId: districtId,
        nid: nid,
        bloodGroup: bloodGroup,
        isActive: isActive,
        note: note,
        covidvaccine: covidVaccine,
        vaccineBrand: vaccineBrand,
        vaccineDose: vaccineDose,
        firstDoseDate: firstDoseDate,
        //  != null ? DateTime.parse(firstDoseDate) : null,
        secondDoseDate: secondDoseDate,
        // != null ? DateTime.parse(secondDoseDate) : null,
        bosterDoseDate: bosterDoseDate,
        // != null ? DateTime.parse(bosterDoseDate) : null,
      );
      try {
        var patientadd = await dbProvider?.createPatient(newPatient);

        if (patientadd > 0) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(context, "/patientofflinelist");
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        scaffoldMessenger
            .showSnackBar(const SnackBar(content: Text("Something wrong!!!")));
      }
    } else {
      PatientOfflineModel newPatient = PatientOfflineModel(
        id: id ?? 0,
        hospitalId: hospitalId,
        branchId: branchId,
        firstName: firstName,
        lastName: lastName,
        day: day,
        month: month,
        year: year,
        mobileNumber: mobileNumber,
        doB: dob,
        // != null ? DateTime.parse(dob) : null,
        gender: gender,
        maritalStatus: maritalStatus,
        primaryMember: primaryMember,
        membershipRegistrationNumber: membershipRegistrationNumber,
        address: address,
        divisionId: divisionId,
        upazilaId: upazilaId,
        districtId: districtId,
        nid: nid,
        bloodGroup: bloodGroup,
        isActive: isActive,
        note: note,
        covidvaccine: covidVaccine,
        vaccineBrand: vaccineBrand,
        vaccineDose: vaccineDose,
        firstDoseDate: firstDoseDate,
        //  != null ? DateTime.parse(firstDoseDate) : null,
        secondDoseDate: secondDoseDate,
        // != null ? DateTime.parse(secondDoseDate) : null,
        bosterDoseDate: bosterDoseDate,
        // != null ? DateTime.parse(bosterDoseDate) : null,
      );
      try {
        var patientadd = await dbProvider?.updatePatient(newPatient);

        if (patientadd > 0) {
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(context, "/patientofflinelist");
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        scaffoldMessenger
            .showSnackBar(const SnackBar(content: Text("Something wrong!!!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Patient Online"),
          automaticallyImplyLeading: true,
        ),
        key: _scaffoldKey,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 450,
                    // height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                child: Column(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        // Search

                                        //End Search

                                        //Name
                                        Row(
                                          children: [
                                            // Name
                                            Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: TextFormField(
                                                  controller:
                                                      _firstNameController,
                                                  maxLength: 30,
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                    hintText: "First Name",
                                                    hintStyle: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: TextFormField(
                                                  controller:
                                                      _lastNameController,
                                                  maxLength: 30,
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black)),
                                                    hintText: "Last Name",
                                                    hintStyle: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //hospital --- Controller ---
                                        Row(
                                          children: [
                                            if (_hospitals.length > 1)
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0, right: 5),
                                                  child:
                                                      DropdownButton<Hospital>(
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple),
                                                    underline: Container(
                                                      height: 2,
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                    ),
                                                    onChanged:
                                                        (Hospital? newValue) {
                                                      setState(() {
                                                        hospitalDropdownValue =
                                                            newValue!.id;
                                                        branchDropdownValue =
                                                            newValue.branchId;
                                                        hospitalValue =
                                                            newValue;
                                                      });
                                                    },
                                                    items: _hospitals.map<
                                                            DropdownMenuItem<
                                                                Hospital>>(
                                                        (Hospital item) {
                                                      return DropdownMenuItem<
                                                          Hospital>(
                                                        child: Text(item.name ??
                                                            "Unknown"),
                                                        value: item,
                                                      );
                                                    }).toList(),
                                                    value: hospitalValue,
                                                    hint: const Text(
                                                        "Hospital Name"),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        //Address
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                                maxLength: 150,
                                                controller: _addressController,
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  hintText: "Address",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 0),
                                              child: DropdownButton(
                                                style: const TextStyle(
                                                    color: Colors.deepPurple),
                                                underline: Container(
                                                  height: 2,
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (int? newValue) {
                                                  fetchDistrict(newValue);
                                                  setState(() {
                                                    divisionDropdownValue =
                                                        newValue!;
                                                  });
                                                },
                                                items: _divisions.map((item) {
                                                  return DropdownMenuItem(
                                                    child: Text(item.name),
                                                    value: item.id,
                                                  );
                                                }).toList(),
                                                value: divisionDropdownValue,
                                                hint:
                                                    const Text("Division Name"),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        Row(
                                          children: [
                                            Expanded(
                                              //flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton(
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (int? newValue) {
                                                    fetchUpazila(newValue);
                                                    setState(() {
                                                      districtDropdownValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: _districts.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(item.name),
                                                      value: item.id,
                                                    );
                                                  }).toList(),
                                                  value: districtDropdownValue,
                                                  hint: const Text(
                                                      "District Name"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton(
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      upazilaDropdownValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: _upazilas.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(item.name),
                                                      value: item.id,
                                                    );
                                                  }).toList(),
                                                  value: upazilaDropdownValue,
                                                  hint: const Text("Upazila"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //NID
                                        TextFormField(
                                          controller: _nidController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 20,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "NID",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                        //Mobile Number
                                        TextFormField(
                                          controller: _mobilenumberController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 11,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton(
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      tobacoHabitDropdown =
                                                          newValue!;
                                                    });
                                                  },
                                                  items:
                                                      _smokinghabit.map((item) {
                                                    return DropdownMenuItem(
                                                      child: Text(item.name),
                                                      value: item.id,
                                                    );
                                                  }).toList(),
                                                  value: tobacoHabitDropdown,
                                                  hint: const Text(
                                                      "Smoking Habit"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Date Of Birth
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(dateOfBirth != null
                                                    ? myFormat.format(
                                                        dateOfBirth ??
                                                            DateTime.now())
                                                    : 'Pick a Date'),
                                                TextButton(
                                                  onPressed: () =>
                                                      _selectDate(context),
                                                  child: const Text(
                                                      'Date Of Birth'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //Gender + Blood Group + Narital status
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: DropdownButton<String>(
                                                  value: genderDropdownValue,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      genderDropdownValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Male',
                                                    'Female',
                                                    'Others',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: const Text("Gender"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 0),
                                                child: DropdownButton<String>(
                                                  value: meritalStatusValue,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      meritalStatusValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Married',
                                                    'Single',
                                                    'Widowed',
                                                    'Separated',
                                                    'Divorced'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint: const Text(
                                                      "Marital Status"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton<String>(
                                                  value: bloodGroupValue,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      bloodGroupValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'O+',
                                                    'O-',
                                                    'A+',
                                                    'A-',
                                                    'B+',
                                                    'B-',
                                                    'AB+',
                                                    'AB-',
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  hint:
                                                      const Text("Blood Group"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Covid 19 Vaccination
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: DropdownButton(
                                                  value: covidVaccine,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      covidVaccine = newValue!;
                                                    });
                                                  },
                                                  items: vaccine.covidVaccine
                                                      .map((Vaccine value) {
                                                    return DropdownMenuItem(
                                                      value: value.value,
                                                      child: Text(value.name),
                                                    );
                                                  }).toList(),
                                                  hint:
                                                      const Text("Vaccination"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton(
                                                  value: vaccineBrand,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      vaccineBrand = newValue!;
                                                    });
                                                  },
                                                  items: vaccine.vaccineBrand
                                                      .map((Vaccine value) {
                                                    return DropdownMenuItem(
                                                      value: value.value,
                                                      child: Text(value.name),
                                                    );
                                                  }).toList(),
                                                  hint: const Text("Brand"),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5.0),
                                                child: DropdownButton(
                                                  value: vaccineDose,
                                                  icon: const Icon(
                                                      Icons.arrow_downward),
                                                  elevation: 16,
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 2,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  onChanged: (int? newValue) {
                                                    setState(() {
                                                      vaccineDose = newValue!;
                                                    });
                                                  },
                                                  items: vaccine.vaccineDose
                                                      .map((Vaccine value) {
                                                    return DropdownMenuItem(
                                                      value: value.value,
                                                      child: Text(value.name),
                                                    );
                                                  }).toList(),
                                                  hint: const Text("Dose"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        // Date
                                        Row(
                                          children: [
                                            if (vaccineDose == 1 ||
                                                vaccineDose == 2 ||
                                                vaccineDose == 3)
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Text(firstDoseDate != null
                                                        ? myFormat.format(
                                                            firstDoseDate ??
                                                                DateTime.now())
                                                        : 'Pick a Date'),
                                                    TextButton(
                                                      onPressed: () =>
                                                          _selectDateForFirstDose(
                                                              context),
                                                      child: const Text(
                                                          '1st Dose'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (vaccineDose == 3 ||
                                                vaccineDose == 2)
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Text(secondDoseDate != null
                                                        ? myFormat.format(
                                                            secondDoseDate ??
                                                                DateTime.now())
                                                        : 'Pick a Date'),
                                                    TextButton(
                                                      onPressed: () =>
                                                          _selectDateForSecondDose(
                                                              context),
                                                      child: const Text(
                                                          '2nd Dose'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            if (vaccineDose == 3)
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    Text(bosterDoseDate != null
                                                        ? myFormat.format(
                                                            bosterDoseDate ??
                                                                DateTime.now())
                                                        : 'Pick a Date'),
                                                    TextButton(
                                                      onPressed: () =>
                                                          _selectDateForBosterDose(
                                                              context),
                                                      child: const Text(
                                                          'Boster Dose'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),

                                        //Note
                                        TextFormField(
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          controller: _noteController,
                                          maxLength: 100,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Note",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        // Membership Registration Number Checkbox

                                        Row(
                                          children: [
                                            // SizedBox(
                                            //   width: 10,
                                            // ),
                                            Checkbox(
                                              checkColor: Color.fromARGB(
                                                  255, 36, 71, 226),
                                              activeColor: Colors.red,
                                              value: primaryMember,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  primaryMember = value!;
                                                });
                                              },
                                            ),
                                            const Text(
                                              'Primary Member',
                                              style: TextStyle(fontSize: 17.0),
                                            ),
                                          ],
                                        ),

                                        // Registration Number
                                        TextFormField(
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                          controller:
                                              _membershipRegistrationNumberController,
                                          maxLength: 20,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText:
                                                "Membership Registration Number",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, right: 0),
                                          child: Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  updatePatient();
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 0),
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Text(
                                                    "UPDATE ONLINE",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    1)),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                child: (isLoading)
                                                    ? Center(
                                                        child: Container(
                                                            height: 26,
                                                            width: 26,
                                                            child:
                                                                const CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors.green,
                                                            )))
                                                    : Container(),
                                                right: 30,
                                                bottom: 0,
                                                top: 0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
