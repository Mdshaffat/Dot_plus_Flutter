import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/Models/patientOfflineModel.dart';
import 'package:hospital_app/pages/patientPages/patientAdd.dart';
import 'package:intl/intl.dart';

import '../../Models/district.dart';
import '../../Models/division.dart';
import '../../Models/hospital.dart';
import '../../Models/patientAdd.dart';
import '../../Models/upazila.dart';
import '../../Models/vaccine.dart';
import '../../providers/db_provider.dart';

class PatientOfflineEdit extends StatefulWidget {
  final PatientOfflineModel patientOfflineModel;
  const PatientOfflineEdit({Key? key, required this.patientOfflineModel})
      : super(key: key);

  @override
  State<PatientOfflineEdit> createState() => _PatientOfflineEditState();
}

class _PatientOfflineEditState extends State<PatientOfflineEdit> {
  int? id;
  final _formKey = GlobalKey<FormState>();
  //
  List<Hospital> _hospitals = [];
  List<Division> _divisions = [];
  List<District> _districts = [];
  List<Upazila> _upazilas = [];
  DBProvider? dbProvider;

  List<SmokingHabit> _smokinghabit = [
    SmokingHabit(id: '1', name: 'Smoker'),
    SmokingHabit(id: '0', name: 'Non Smoker')
  ];

  NewVaccine vaccine = NewVaccine();
  bool isLoading = false;
  // late String email, password;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _ageDayController = TextEditingController();
  final TextEditingController _ageMonthController = TextEditingController();
  final TextEditingController _ageYearController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _membershipRegistrationNumberController =
      TextEditingController();
  final TextEditingController _bodyTemparatureController =
      TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _pulseRateController = TextEditingController();
  final TextEditingController _spo2Controller = TextEditingController();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _appearanceController = TextEditingController();
  final TextEditingController _anemiaController = TextEditingController();
  final TextEditingController _jaundiceController = TextEditingController();
  final TextEditingController _dehydrationController = TextEditingController();
  final TextEditingController _edemaController = TextEditingController();
  final TextEditingController _cyanosisController = TextEditingController();
  final TextEditingController _rbsController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  Hospital? hospitalValue;
  int? hospitalDropdownValue;
  int? branchDropdownValue;
  int? divisionDropdownValue;
  int? districtDropdownValue;
  int? upazilaDropdownValue;
  String? genderDropdownValue;
  bool isActive = true;
  DateTime? dateOfBirth;
  String? meritalStatusValue;
  String? smokingDropdownValue;
  String? bloodGroupValue;
  int? covidVaccine;
  int? vaccineBrand;
  int? vaccineDose;
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  DateTime? bosterDoseDate;
  bool primaryMember = false;

  int? heightFeetValue;
  int? heightInchValue;

  var myFormat = DateFormat('d-MM-yyyy');

  //
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    fetchHospitals();
    fetchDivision();
    pathcValue();
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
    _ageDayController.dispose();
    _ageMonthController.dispose();
    _ageYearController.dispose();
    _noteController.dispose();
    _membershipRegistrationNumberController.dispose();
    _bodyTemparatureController.dispose();
    _weightController.dispose();
    _pulseRateController.dispose();
    _spo2Controller.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _appearanceController.dispose();
    _anemiaController.dispose();
    _jaundiceController.dispose();
    _dehydrationController.dispose();
    _edemaController.dispose();
    _cyanosisController.dispose();
    _rbsController.dispose();
  }

  pathcValue() async {
    var patientPatch = widget.patientOfflineModel;
    if (patientPatch.divisionId != null) {
      await fetchDistrict(patientPatch.divisionId);
      await fetchUpazila(patientPatch.districtId);
    }
    List<Hospital> hospitalList =
        await dbProvider?.getHospitalById(patientPatch.hospitalId);
    if (hospitalList.isNotEmpty) {
      Hospital hospital = hospitalList[0];
      _hospitals.add(hospital);
      hospitalValue = hospital;
    }
    id = patientPatch.id;
    _firstNameController.text = patientPatch.firstName ?? '';
    _lastNameController.text = patientPatch.lastName ?? '';
    _addressController.text = patientPatch.address ?? '';
    _nidController.text = patientPatch.nid ?? '';
    _mobilenumberController.text = patientPatch.mobileNumber ?? '';
    _ageDayController.text =
        patientPatch.day != null ? patientPatch.day.toString() : '';
    _ageMonthController.text =
        patientPatch.month != null ? patientPatch.month.toString() : '';
    _ageYearController.text =
        patientPatch.day != null ? patientPatch.day.toString() : '';
    _noteController.text = patientPatch.note ?? '';
    _membershipRegistrationNumberController.text =
        patientPatch.membershipRegistrationNumber ?? '';
    _bodyTemparatureController.text = patientPatch.bodyTemparature ?? '';
    _weightController.text =
        patientPatch.weight != null ? patientPatch.weight.toString() : '';
    _pulseRateController.text =
        patientPatch.pulseRate != null ? patientPatch.pulseRate.toString() : '';
    _spo2Controller.text =
        patientPatch.spO2 != null ? patientPatch.spO2.toString() : '';
    _systolicController.text = patientPatch.bloodPressureSystolic ?? '';
    _diastolicController.text = patientPatch.bloodPressureDiastolic ?? '';
    _appearanceController.text = patientPatch.appearance ?? '';
    _anemiaController.text = patientPatch.anemia ?? '';
    _jaundiceController.text = patientPatch.jaundice ?? '';
    _dehydrationController.text = patientPatch.dehydration ?? '';
    _edemaController.text = patientPatch.edema ?? '';
    _cyanosisController.text = patientPatch.cyanosis ?? '';
    _rbsController.text = patientPatch.rbsFbs ?? '';
    hospitalDropdownValue = patientPatch.hospitalId;
    branchDropdownValue = patientPatch.branchId;
    divisionDropdownValue = patientPatch.divisionId;
    districtDropdownValue = patientPatch.districtId;
    upazilaDropdownValue = patientPatch.upazilaId;
    genderDropdownValue = patientPatch.gender;
    isActive = patientPatch.isActive == 1 ? true : false;
    dateOfBirth = patientPatch.doB == null
        ? null
        : DateTime.parse(patientPatch.doB.toString());
    meritalStatusValue = patientPatch.maritalStatus;
    smokingDropdownValue = patientPatch.tobacoHabit;
    bloodGroupValue = patientPatch.bloodGroup;
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
    primaryMember = patientPatch.primaryMember == 1 ? true : false;

    heightFeetValue = patientPatch.heightFeet;
    heightInchValue = patientPatch.heightInches;
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
    setState(() {
      isLoading = true;
    });
    List<Hospital> totalHospital = await dbProvider?.getAllHospital();
    if (totalHospital.length > 1) {
      _hospitals = totalHospital;
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
    smokingHabit,
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
    bodyTemparature,
    weight,
    heightFeet,
    heightInch,
    pulseRate,
    spo2,
    systolic,
    diastolic,
    appearance,
    anemia,
    jaundice,
    dehydration,
    edema,
    cyanosis,
    rbsfbs,
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
        tobacoHabit: smokingHabit,
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
        heightFeet: heightFeet,
        heightInches: heightInch,
        weight: weight,
        bodyTemparature: bodyTemparature,
        appearance: appearance,
        anemia: anemia,
        jaundice: jaundice,
        dehydration: dehydration,
        edema: edema,
        cyanosis: cyanosis,
        rbsFbs: rbsfbs,
        bloodPressureSystolic: systolic,
        bloodPressureDiastolic: diastolic,
        pulseRate: pulseRate,
        spO2: spo2,
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
        heightFeet: heightFeet,
        heightInches: heightInch,
        weight: weight,
        bodyTemparature: bodyTemparature,
        appearance: appearance,
        anemia: anemia,
        jaundice: jaundice,
        dehydration: dehydration,
        edema: edema,
        cyanosis: cyanosis,
        rbsFbs: rbsfbs,
        bloodPressureSystolic: systolic,
        bloodPressureDiastolic: diastolic,
        pulseRate: pulseRate,
        spO2: spo2,
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
            title: const Text("Update Patient"),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, "/patientofflinelist"),
            )),
        key: _scaffoldKey,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                              children: <Widget>[
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
                                          controller: _firstNameController,
                                          maxLength: 30,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
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
                                          controller: _lastNameController,
                                          maxLength: 30,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
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
                                          padding: const EdgeInsets.only(
                                              left: 0, right: 5),
                                          child: DropdownButton<Hospital>(
                                            style: const TextStyle(
                                                color: Colors.deepPurple),
                                            underline: Container(
                                              height: 2,
                                              color: Colors.deepPurpleAccent,
                                            ),
                                            onChanged: (Hospital? newValue) {
                                              setState(() {
                                                hospitalDropdownValue =
                                                    newValue!.id;
                                                branchDropdownValue =
                                                    newValue.branchId;
                                                hospitalValue = newValue;
                                              });
                                            },
                                            items: _hospitals.map<
                                                    DropdownMenuItem<Hospital>>(
                                                (Hospital item) {
                                              return DropdownMenuItem<Hospital>(
                                                child: Text(
                                                    item.name ?? "Unknown"),
                                                value: item,
                                              );
                                            }).toList(),
                                            value: hospitalValue,
                                            hint: const Text("Hospital Name"),
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
                                        decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
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
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          fetchDistrict(newValue);
                                          setState(() {
                                            divisionDropdownValue = newValue!;
                                          });
                                        },
                                        items: _divisions.map((item) {
                                          return DropdownMenuItem(
                                            child: Text(item.name),
                                            value: item.id,
                                          );
                                        }).toList(),
                                        value: divisionDropdownValue,
                                        hint: const Text("Division Name"),
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
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (int? newValue) {
                                            fetchUpazila(newValue);
                                            setState(() {
                                              districtDropdownValue = newValue!;
                                            });
                                          },
                                          items: _districts.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.name),
                                              value: item.id,
                                            );
                                          }).toList(),
                                          value: districtDropdownValue,
                                          hint: const Text("District Name"),
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
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              upazilaDropdownValue = newValue!;
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
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "NID",
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                ),
                                //Mobile Number
                                TextFormField(
                                  controller: _mobilenumberController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 11,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Mobile Number",
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              smokingDropdownValue = newValue!;
                                            });
                                          },
                                          items: _smokinghabit.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.name),
                                              value: item.id,
                                            );
                                          }).toList(),
                                          value: smokingDropdownValue,
                                          hint: const Text("Smoking Name"),
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
                                                dateOfBirth ?? DateTime.now())
                                            : 'Pick a Date'),
                                        TextButton(
                                          onPressed: () => _selectDate(context),
                                          child: const Text('Date Of Birth'),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 25, right: 25),
                                        child: TextFormField(
                                          controller: _ageDayController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 2,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Day",
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
                                            left: 5, right: 5),
                                        child: TextFormField(
                                          controller: _ageMonthController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 2,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Month",
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
                                            left: 5, right: 5),
                                        child: TextFormField(
                                          controller: _ageYearController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Year",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              genderDropdownValue = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Male',
                                            'Female',
                                            'Others',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              meritalStatusValue = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Married',
                                            'Single',
                                            'Widowed',
                                            'Separated',
                                            'Divorced'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: const Text("Marital Status"),
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              bloodGroupValue = newValue!;
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
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          hint: const Text("Blood Group"),
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
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
                                          hint: const Text("Vaccination"),
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
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
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
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
                                          mainAxisSize: MainAxisSize.max,
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
                                              child: const Text('1st Dose'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (vaccineDose == 3 || vaccineDose == 2)
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
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
                                              child: const Text('2nd Dose'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (vaccineDose == 3)
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
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
                                              child: const Text('Boster Dose'),
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
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Note",
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
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
                                      checkColor:
                                          Color.fromARGB(255, 36, 71, 226),
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
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Membership Registration Number",
                                    hintStyle: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // vITALS

                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller:
                                              _bodyTemparatureController,
                                          maxLength: 5,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Body Temperature",
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
                                          controller: _weightController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Weight",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: DropdownButton<int>(
                                          value: heightFeetValue,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              heightFeetValue = newValue!;
                                            });
                                          },
                                          items: <int>[
                                            1,
                                            2,
                                            3,
                                            4,
                                            5,
                                            6,
                                            7,
                                            8,
                                          ].map<DropdownMenuItem<int>>(
                                              (int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                          hint: const Text("Height Feet"),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: DropdownButton<int>(
                                          value: heightInchValue,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              heightInchValue = newValue!;
                                            });
                                          },
                                          items: <int>[
                                            1,
                                            2,
                                            3,
                                            4,
                                            5,
                                            6,
                                            7,
                                            8,
                                            9,
                                            10,
                                            11
                                          ].map<DropdownMenuItem<int>>(
                                              (int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                          hint: const Text("Inch"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _pulseRateController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Pulse Rate",
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
                                          controller: _spo2Controller,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "SpO2",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _systolicController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Systolic",
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
                                          controller: _diastolicController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Diastolic",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _appearanceController,
                                          maxLength: 10,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Appearance",
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
                                          controller: _anemiaController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Anemia",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _jaundiceController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Jaundice",
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
                                          controller: _dehydrationController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Dehydration",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _edemaController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Edema",
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
                                          controller: _cyanosisController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "Cyanosis",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0),
                                        child: TextFormField(
                                          controller: _rbsController,
                                          maxLength: 3,
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            hintText: "RBS/FBS",
                                            hintStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, right: 0),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (isLoading) {
                                            return;
                                          }
                                          if (hospitalDropdownValue == null ||
                                              (_firstNameController
                                                      .text.isEmpty &&
                                                  _lastNameController
                                                      .text.isEmpty) ||
                                              (_ageDayController.text.isEmpty &&
                                                  _ageMonthController
                                                      .text.isEmpty &&
                                                  _ageYearController
                                                      .text.isEmpty &&
                                                  dateOfBirth == null)) {
                                            scaffoldMessenger.showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        "Please Fill Name , Hospital and (Date Of Birth or Age) Properly")));
                                            return;
                                          }
                                          updatePatientToSqlte(
                                              _firstNameController.text,
                                              _lastNameController.text,
                                              hospitalDropdownValue,
                                              branchDropdownValue,
                                              _addressController.text,
                                              divisionDropdownValue,
                                              districtDropdownValue,
                                              upazilaDropdownValue,
                                              _nidController.text,
                                              _mobilenumberController.text,
                                              genderDropdownValue,
                                              (_ageDayController.text != null && _ageDayController.text != "")
                                                  ? int.parse(
                                                      _ageDayController.text)
                                                  : null,
                                              (_ageMonthController.text != null && _ageMonthController.text != "")
                                                  ? int.parse(
                                                      _ageMonthController.text)
                                                  : null,
                                              (_ageYearController.text != null && _ageYearController.text != "")
                                                  ? int.parse(
                                                      _ageYearController.text)
                                                  : null,
                                              dateOfBirth == null
                                                  ? null
                                                  : dateOfBirth!.toString(),
                                              meritalStatusValue,
                                              smokingDropdownValue,
                                              bloodGroupValue,
                                              covidVaccine.toString(),
                                              vaccineBrand.toString(),
                                              vaccineDose.toString(),
                                              firstDoseDate == null
                                                  ? null
                                                  : firstDoseDate!.toString(),
                                              secondDoseDate == null
                                                  ? null
                                                  : secondDoseDate!.toString(),
                                              bosterDoseDate == null
                                                  ? null
                                                  : bosterDoseDate!.toString(),
                                              _noteController.text,
                                              primaryMember ? 1 : 0,
                                              _membershipRegistrationNumberController
                                                  .text,
                                              isActive ? 1 : 0,
                                              _bodyTemparatureController.text,
                                              (_weightController.text != null && _weightController.text != "")
                                                  ? int.parse(
                                                      _weightController.text)
                                                  : null,
                                              heightFeetValue,
                                              heightInchValue,
                                              (_pulseRateController.text != null &&
                                                      _pulseRateController.text !=
                                                          "")
                                                  ? int.parse(
                                                      _pulseRateController.text)
                                                  : null,
                                              (_spo2Controller.text != null &&
                                                      _spo2Controller.text != "")
                                                  ? int.parse(_spo2Controller.text)
                                                  : null,
                                              _systolicController.text,
                                              _diastolicController.text,
                                              _appearanceController.text,
                                              _anemiaController.text,
                                              _jaundiceController.text,
                                              _dehydrationController.text,
                                              _edemaController.text,
                                              _cyanosisController.text,
                                              _rbsController.text);
                                          setState(() {
                                            isLoading = true;
                                          });
                                          // Navigator.pushReplacementNamed(
                                          //     context, "/home");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            "SAVE OFFLINE",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    letterSpacing: 1)),
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
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}
