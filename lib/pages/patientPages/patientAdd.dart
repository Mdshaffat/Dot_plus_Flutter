import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/Models/district.dart';
import 'package:hospital_app/Models/hospital.dart';
import 'package:hospital_app/Models/upazila.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../API/api.dart';
import '../../Models/Division.dart';

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
  @override
  void initState() {
    super.initState();
    fetchHospitals();
    fetchDivision();
    // fetchAllDistrict();
    // fetchAllUpazila();
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  // late String email, password;
  bool isLoading = false;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _divisionController = new TextEditingController();
  TextEditingController _districtController = new TextEditingController();
  TextEditingController _upazilaController = new TextEditingController();
  TextEditingController _nidController = new TextEditingController();
  TextEditingController _mobilenumberController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _ageYearController = new TextEditingController();
  TextEditingController _ageMonthController = new TextEditingController();
  TextEditingController _ageDayController = new TextEditingController();
  DateTime currentDate = DateTime.now();
  TextEditingController _maritalStatusController = new TextEditingController();
  TextEditingController _bloodGroupController = new TextEditingController();
  TextEditingController _covid19VaccinationController =
      new TextEditingController();
  TextEditingController _vaccineNameController = new TextEditingController();
  TextEditingController _vaccineDoseController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  TextEditingController _primaryMenberController = new TextEditingController();
  TextEditingController _RegistrationNumberController =
      new TextEditingController();
  TextEditingController _bodyTemparatureController =
      new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  TextEditingController _heightFeetController = new TextEditingController();
  TextEditingController _heightInchController = new TextEditingController();
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
  String dropdownValue = 'One';
  int hospitalDropdownValue = 1;
  int divisionDropdownValue = 1;
  int? districtDropdownValue;
  int upazilaDropdownValue = 1;
  String genderDropdownValue = "Male";
  String meritalStatusValue = "Single";
  String bloodGroupValue = "O+";
  String vaccinationValue = "Yes";
  String vaccineValue = "Pfizer";
  String vaccineDoseValue = "1st Dose";
  String? heightFeetValue;
  String? heightInchValue;
  var myFormat = DateFormat('d-MM-yyyy');
  late ScaffoldMessengerState scaffoldMessenger;
//
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
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
            // width: MediaQuery.of(context).size.width,
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
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 0, right: 5),
                                        child: DropdownButton(
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              hospitalDropdownValue = newValue!;
                                            });
                                          },
                                          items: _hospitals.map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item.Name),
                                              value: item.Id,
                                            );
                                          }).toList(),
                                          value: hospitalDropdownValue,
                                          hint: const Text("Hospital Name"),
                                        ),
                                      ),
                                    ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Padding(
                                  //     padding:
                                  //         EdgeInsets.only(left: 1, right: 0),
                                  //     child: DropdownButton<String>(
                                  //       value: dropdownValue,
                                  //       icon: const Icon(Icons.arrow_downward),
                                  //       elevation: 16,
                                  //       style: const TextStyle(
                                  //           color: Colors.deepPurple),
                                  //       underline: Container(
                                  //         height: 2,
                                  //         color: Colors.deepPurpleAccent,
                                  //       ),
                                  //       onChanged: (String? newValue) {
                                  //         setState(() {
                                  //           dropdownValue = newValue!;
                                  //         });
                                  //       },
                                  //       items: <String>[
                                  //         'One',
                                  //         'Two',
                                  //         'Free',
                                  //         'Four'
                                  //       ].map<DropdownMenuItem<String>>(
                                  //           (String value) {
                                  //         return DropdownMenuItem<String>(
                                  //           value: value,
                                  //           child: Text(value),
                                  //         );
                                  //       }).toList(),
                                  //       hint: Text("Branch Name"),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              //Address
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Address",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: DropdownButton(
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (int? newValue) {
                                          print("Method Called");
                                          print(newValue);
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
                                          // if (newValue != null) {
                                          //   fetchUpazila(newValue);
                                          // }
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
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                              ),
                              // Date Of Birth
                              Row(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('${myFormat.format(currentDate)}'),
                                      TextButton(
                                        onPressed: () => _selectDate(context),
                                        child: Text('Date Of Birth'),
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
                                      child: DropdownButton<String>(
                                        value: vaccinationValue,
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
                                            vaccinationValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Yes',
                                          'No',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButton<String>(
                                        value: vaccineValue,
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
                                            vaccineValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          "Pfizer",
                                          "Astrazeneca",
                                          "Moderna",
                                          "Sinopharm"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButton<String>(
                                        value: vaccineDoseValue,
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
                                            vaccineDoseValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          "1st Dose",
                                          "2nd Dose",
                                          "Boster Dose"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Note
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _bloodGroupController,
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
                              // Registration Number
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: _bloodGroupController,
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
                                      child: DropdownButton(
                                        value: heightFeetValue,
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
                                            heightFeetValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          "1",
                                          "2",
                                          "3",
                                          "4",
                                          "5",
                                          "6",
                                          "7",
                                          "8",
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
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
                                      child: DropdownButton(
                                        value: heightInchValue,
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
                                            heightInchValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          "1",
                                          "2",
                                          "3",
                                          "4",
                                          "5",
                                          "6",
                                          "7",
                                          "8",
                                          "9",
                                          "10",
                                          "11"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
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
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: TextFormField(
                                        controller: _rbsController,
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
                                /* 
                                 hospitalId,
      firstName,
      lastName,
      mobileNumber,
      dob,
      gender,
      maritalStatus,
      membershipRegistrationNumber,
      address,
      divisionId,
      nid,
      bloodGroup,
      note,
      vaccineBrand,
      heightFeet,
      heightInch,
      weight,
      bmi,
      bodyTemparature,
      appearance,
      anemia,
      jaundice,
      dehydration,
      edema,
      cyanosis,
      rbsfbs,
      systolic,
      diastolic,
      spo2
                                 */
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        // if (_emailController.text.isEmpty ||
                                        //     _passwordController.text.isEmpty) {
                                        //   scaffoldMessenger.showSnackBar(
                                        //       const SnackBar(
                                        //           content: Text(
                                        //               "Please Fill all fileds")));
                                        //   return;
                                        // }
                                        addPatient(
                                            hospitalDropdownValue.toInt(),
                                            _firstNameController.text,
                                            _lastNameController.text,
                                            _mobilenumberController.text,
                                            currentDate.toString(),
                                            genderDropdownValue,
                                            meritalStatusValue,
                                            //

                                            _addressController.text,
                                            divisionDropdownValue.toInt(),
                                            _nidController.text,
                                            bloodGroupValue,
                                            _noteController.text,
                                            vaccineValue,
                                            heightFeetValue,
                                            heightInchValue,
                                            _weightController.text,
                                            //
                                            _bodyTemparatureController.text,
                                            _appearanceController.text,
                                            _anemiaController.text,
                                            _jaundiceController.text,
                                            _dehydrationController.text,
                                            _edemaController.text,
                                            _cyanosisController.text,
                                            _rbsController.text,
                                            _systolicController.text,
                                            _diastolicController.text,
                                            _spo2Controller.text);
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
                                          "SUBMIT",
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
    final response = await http.get(Uri.parse(HOSPITALURI));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = jsonDecode(response.body);
      for (var item in jsonresponse) {
        hospitals.add(Hospital.fromJson(item));
      }
      _hospitals = hospitals;
      if (_hospitals.length > 2) {
        setState(() {});
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  fetchDivision() async {
    List<Division> divisions = [];
    _divisions = [];
    final response = await http.get(Uri.parse(DIVISIONURI));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = jsonDecode(response.body);
      for (var item in jsonresponse) {
        divisions.add(Division.fromJson(item));
      }
      _divisions = divisions;
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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
    List<District> district = [];
    final response = await http.get(Uri.parse(DISTRICTURI + id.toString()));

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

  fetchUpazila(id) async {
    List<Upazila> upazila = [];
    final response = await http.get(Uri.parse(UPAZILAURI + id));

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

  addPatient(
      hospitalId,
      firstName,
      lastName,
      mobileNumber,
      dob,
      gender,
      maritalStatus,
      // membershipRegistrationNumber,
      address,
      divisionId,
      nid,
      bloodGroup,
      note,
      vaccineBrand,
      heightFeet,
      heightInch,
      weight,
      // bmi,
      bodyTemparature,
      appearance,
      anemia,
      jaundice,
      dehydration,
      edema,
      cyanosis,
      rbsfbs,
      systolic,
      diastolic,
      spo2) async {
    var data = jsonEncode({
      'hospitalId': hospitalId,
      // 'branchId': 0,
      'firstName': firstName,
      'lastName': lastName,
      // 'day': 0,
      // 'month': 0,
      // 'year': 0,
      // 'age': 'string',
      'mobileNumber': mobileNumber,
      'doB': dob,
      'gender': gender,
      'maritalStatus': maritalStatus,
      // 'primaryMember': true,
      // 'membershipRegistrationNumber': membershipRegistrationNumber,
      'address': address,
      'divisionId': divisionId,
      // 'division': 'string',
      // 'upazilaId': 0,
      // 'districtId': 0,
      'nid': nid,
      'bloodGroup': bloodGroup,
      'isActive': true,
      'note': note,
      // 'covidvaccine': 'string',
      // 'vaccineBrand': 'string',
      // 'vaccineDose': 'string',
      // 'firstDoseDate': '2022-03-22T13:15:46.372Z',
      // 'secondDoseDate': '2022-03-22T13:15:46.372Z',
      // 'bosterDoseDate': '2022-03-22T13:15:46.372Z',
      'heightFeet': heightFeet,
      'heightInches': heightInchValue,
      'weight': weight,
      // 'bmi': bmi,
      'bodyTemparature': bodyTemparature,
      'appearance': appearance,
      'anemia': anemia,
      'jaundice': jaundice,
      'dehydration': dehydration,
      'edema': edema,
      'cyanosis': cyanosis,
      // 'heart': '',
      // 'lung': 'string',
      // 'abdomen': 'string',
      // 'kub': 'string',
      'rbsFbs': rbsfbs,
      'bloodPressureSystolic': systolic,
      'bloodPressureDiastolic': diastolic,
      // 'heartRate': 'hea',
      // 'pulseRate': '',
      'spO2': spo2,
      // 'waist': '',
      // 'hip': 'string'
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    print(data.toString());
    if (token != null) {
      final response = await http.post(Uri.parse(PATIENTURI),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
            "Authorization": 'Bearer $token',
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
      // setState(() {
      //   isLoading = false;
      // });
      print(token);
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
        }
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text("${resposne['message']}")));
      } else {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text("{response.statusCode}")));
        print(response.statusCode);
      }
    }
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
