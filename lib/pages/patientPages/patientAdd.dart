import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/patientAdd.dart';
import 'package:hospital_app/Models/upazila.dart';
import 'package:hospital_app/Models/vaccine.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../API/api.dart';
import '../../Models/division.dart';
import '../../providers/db_provider.dart';

class PatientAdd extends StatefulWidget {
  const PatientAdd({Key? key}) : super(key: key);

  @override
  _PatientAddState createState() => _PatientAddState();
}

class _PatientAddState extends State<PatientAdd> {
  List<Hospital> _hospitals = [];
  List<Division> _divisions = [];
  List<District> _districts = [];
  List<Upazila> _upazilas = [];
  DBProvider? dbProvider;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    fetchHospitals();
    fetchDivision();
    // fetchAllDistrict();
    // fetchAllUpazila();
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  // late String email, password;
  NewVaccine vaccine = NewVaccine();
  bool isLoading = false;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  Hospital? hospitalValue;
  int? hospitalDropdownValue;
  int? branchDropdownValue;
  TextEditingController _addressController = new TextEditingController();
  int? divisionDropdownValue;
  int? districtDropdownValue;
  int? upazilaDropdownValue;
  TextEditingController _nidController = new TextEditingController();
  TextEditingController _mobilenumberController = new TextEditingController();
  String? genderDropdownValue;
  TextEditingController _ageDayController = new TextEditingController();
  TextEditingController _ageMonthController = new TextEditingController();
  TextEditingController _ageYearController = new TextEditingController();
  DateTime? dateOfBirth;
  String? meritalStatusValue;
  String? bloodGroupValue;
  int? covidVaccine;
  int? vaccineBrand;
  int? vaccineDose;
  DateTime? firstDoseDate;
  DateTime? secondDoseDate;
  DateTime? bosterDoseDate;
  TextEditingController _noteController = new TextEditingController();
  bool primaryMember = false;
  TextEditingController _membershipRegistrationNumberController =
      new TextEditingController();
  bool isActive = true;
  TextEditingController _bodyTemparatureController =
      new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  int? heightFeetValue;
  int? heightInchValue;
  TextEditingController _pulseRateController = new TextEditingController();
  TextEditingController _spo2Controller = new TextEditingController();
  TextEditingController _systolicController = new TextEditingController();
  TextEditingController _diastolicController = new TextEditingController();
  TextEditingController _appearanceController = new TextEditingController();
  TextEditingController _anemiaController = new TextEditingController();
  TextEditingController _jaundiceController = new TextEditingController();
  TextEditingController _dehydrationController = new TextEditingController();
  TextEditingController _edemaController = new TextEditingController();
  TextEditingController _cyanosisController = new TextEditingController();
  TextEditingController _rbsController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var myFormat = DateFormat('d-MM-yyyy');
  late ScaffoldMessengerState scaffoldMessenger;
//
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != dateOfBirth)
      setState(() {
        dateOfBirth = pickedDate;
      });
  }

  Future<void> _selectDateForFirstDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != firstDoseDate)
      setState(() {
        firstDoseDate = pickedDate;
      });
  }

  Future<void> _selectDateForSecondDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != secondDoseDate)
      setState(() {
        secondDoseDate = pickedDate;
      });
  }

  Future<void> _selectDateForBosterDose(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != bosterDoseDate)
      setState(() {
        bosterDoseDate = pickedDate;
      });
  }

//
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        appBar: AppBar(
            title: Text("Patient Add"),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/patientlist"),
            )),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            //width: 100,
            // height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                                  newValue!.Id;
                                              branchDropdownValue =
                                                  newValue.BranchId;
                                              hospitalValue = newValue;
                                            });
                                          },
                                          items: _hospitals
                                              .map<DropdownMenuItem<Hospital>>(
                                                  (Hospital item) {
                                            return DropdownMenuItem<Hospital>(
                                              child:
                                                  Text(item.Name ?? "Unknown"),
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
                                    padding: EdgeInsets.only(left: 0, right: 0),
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
                                          child: Text(item.Name),
                                          value: item.Id,
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
                                            child: Text(item.Name),
                                            value: item.Id,
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
                                      padding: EdgeInsets.only(
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
                                            child: Text(item.Name),
                                            value: item.Id,
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
                              const SizedBox(
                                height: 30,
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
                                      padding:
                                          EdgeInsets.only(left: 25, right: 25),
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
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: DropdownButton<String>(
                                        value: genderDropdownValue,
                                        icon: const Icon(Icons.arrow_downward),
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
                                        hint: Text("Gender"),
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
                                        icon: const Icon(Icons.arrow_downward),
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
                                        hint: Text("Marital Status"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButton<String>(
                                        value: bloodGroupValue,
                                        icon: const Icon(Icons.arrow_downward),
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
                                        hint: Text("Blood Group"),
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: DropdownButton(
                                        value: covidVaccine,
                                        icon: const Icon(Icons.arrow_downward),
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
                                            value: value.Value,
                                            child: Text(value.Name),
                                          );
                                        }).toList(),
                                        hint: Text("Vaccination"),
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
                                        icon: const Icon(Icons.arrow_downward),
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
                                            value: value.Value,
                                            child: Text(value.Name),
                                          );
                                        }).toList(),
                                        hint: Text("Brand"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButton(
                                        value: vaccineDose,
                                        icon: const Icon(Icons.arrow_downward),
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
                                            value: value.Value,
                                            child: Text(value.Name),
                                          );
                                        }).toList(),
                                        hint: Text("Dose"),
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
                                              ? myFormat.format(firstDoseDate ??
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
                                    value: this.primaryMember,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        primaryMember = value!;
                                      });
                                    },
                                  ),
                                  Text(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: TextFormField(
                                        controller: _bodyTemparatureController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 3,
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: DropdownButton<int>(
                                        value: heightFeetValue,
                                        icon: const Icon(Icons.arrow_downward),
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
                                        hint: Text("Height Feet"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButton<int>(
                                        value: heightInchValue,
                                        icon: const Icon(Icons.arrow_downward),
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
                                        hint: Text("Inch"),
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                      padding: EdgeInsets.only(
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
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                padding: EdgeInsets.only(top: 15, right: 0),
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
                                        addPatientToSqlte(
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
                                            (_ageMonthController.text != null &&
                                                    _ageMonthController.text !=
                                                        "")
                                                ? int.parse(
                                                    _ageMonthController.text)
                                                : null,
                                            (_ageYearController.text != null &&
                                                    _ageYearController.text !=
                                                        "")
                                                ? int.parse(
                                                    _ageYearController.text)
                                                : null,
                                            dateOfBirth == null
                                                ? null
                                                : dateOfBirth!.toString(),
                                            meritalStatusValue,
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
                                            primaryMember,
                                            _membershipRegistrationNumberController
                                                .text,
                                            isActive,
                                            _bodyTemparatureController.text,
                                            (_weightController.text != null &&
                                                    _weightController.text !=
                                                        "")
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
                                            (_spo2Controller.text != null && _spo2Controller.text != "")
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
                ),
              ],
            ),
          ),
        ));
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

//all district
  fetchAllDistrict() async {
    List<District> district = [];
    final response = await http.get(Uri.parse(ALLDISTRICTURI));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = jsonDecode(response.body);
      for (var item in jsonresponse) {
        district.add(District.fromJson(item));
      }
      _districts = district;
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // All Upazila
  fetchAllUpazila() async {
    List<Upazila> upazila = [];
    final response = await http.get(Uri.parse(ALLUPAZILAURI));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = jsonDecode(response.body);
      for (var item in jsonresponse) {
        upazila.add(Upazila.fromJson(item));
      }
      _upazilas = upazila;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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

  addPatient(
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
    var data = jsonEncode({
      'hospitalId': hospitalId,
      'branchId': branchId,
      'firstName': firstName,
      'lastName': lastName,
      'day': day,
      'month': month,
      'year': year,
      'mobileNumber': mobileNumber,
      'doB': dob,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'primaryMember': primaryMember,
      'membershipRegistrationNumber': membershipRegistrationNumber,
      'address': address,
      'divisionId': divisionId,
      'upazilaId': upazilaId,
      'districtId': districtId,
      'nid': nid,
      'bloodGroup': bloodGroup,
      'isActive': isActive,
      'note': note,
      'covidvaccine': covidVaccine,
      'vaccineBrand': vaccineBrand,
      'vaccineDose': vaccineDose,
      'firstDoseDate': firstDoseDate,
      'secondDoseDate': secondDoseDate,
      'bosterDoseDate': bosterDoseDate,
      'heightFeet': heightFeet,
      'heightInches': heightInch,
      'weight': weight,
      'bodyTemparature': bodyTemparature,
      'appearance': appearance,
      'anemia': anemia,
      'jaundice': jaundice,
      'dehydration': dehydration,
      'edema': edema,
      'cyanosis': cyanosis,
      'rbsFbs': rbsfbs,
      'bloodPressureSystolic': systolic,
      'bloodPressureDiastolic': diastolic,
      'pulseRate': pulseRate,
      'spO2': spo2,
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");

    if (token != null) {
      final response = await http.post(Uri.parse(PATIENTURI),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": 'Bearer $token',
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne.isNotEmpty) {
          // savePref(resposne['userId'], resposne['email'], resposne['token'],
          //     resposne['firstName'], resposne['lastName']);

          // getdata();
          scaffoldMessenger
              .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
          Navigator.pushReplacementNamed(context, "/patientlist");
        } else {
          print(" ${resposne['message']}");
          setState(() {
            isLoading = false;
          });
        }
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.statusCode);
      }
    }
  }

  addPatientToSqlte(
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
    // try {
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
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Something wrong!!!")));
    }
    // }
    // catch(e)
    // {
    //   scaffoldMessenger
    //       .showSnackBar(const SnackBar(content: Text("Something wrong!!!")));
    // }
  }

  savePref(
    String id,
    String email,
    String token,
    String firstName,
    String lastName,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("email", email);
    preferences.setString("token", token);
    preferences.setString("firstName", firstName);
    preferences.setString("lastName", lastName);
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? id = preferences.getString("id");
    final String? email = preferences.getString("email");
    final String? token = preferences.getString("token");
    print(id);
    print(email);
    print(token);
  }
}
