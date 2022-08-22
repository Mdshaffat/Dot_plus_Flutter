import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hospital_app/Models/physicalStatModel/physical_stat.dart';
import 'package:hospital_app/widgets/IntegerDropDown.dart';
import 'package:hospital_app/widgets/multiline_text_field.dart';

import '../../providers/db_provider.dart';
import '../../widgets/RoundedButton.dart';
import '../../widgets/StringDropDown.dart';

class PhysicalStatAdd extends StatefulWidget {
  const PhysicalStatAdd({Key? key}) : super(key: key);

  @override
  State<PhysicalStatAdd> createState() => _PhysicalStatAddState();
}

class _PhysicalStatAddState extends State<PhysicalStatAdd> {
  final TextEditingController _patientId = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _bodytemparature = TextEditingController();
  final TextEditingController _appearance = TextEditingController();
  final TextEditingController _rbsFbs = TextEditingController();
  final TextEditingController _bloodPressuresystolic = TextEditingController();
  final TextEditingController _bloodPressureDiastolic = TextEditingController();
  final TextEditingController _pulseRate = TextEditingController();
  final TextEditingController _spo2 = TextEditingController();

  //dropDown
  int? heightFeet;
  int? heightInch;
  String? anemia;
  String? jaundice;
  String? dehydration;
  String? edema;
  String? cyanosis;

  List<int> heightf = [1, 2, 3, 4, 5, 6, 7, 8];
  List<int> heightin = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  List<String> isPositive = ['+', '-'];
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;
  DBProvider? dbProvider;

// Add Data To Local Db

  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
  }

  @override
  void dispose() {
    super.dispose();
    _patientId.dispose();
    _weight.dispose();
    _bodytemparature.dispose();
    _appearance.dispose();
    _rbsFbs.dispose();
    _bloodPressuresystolic.dispose();
    _bloodPressureDiastolic.dispose();
    _pulseRate.dispose();
    _spo2.dispose();
  }

  _savePhysicalStatToLocalDb() async {
    setState(() {
      isLoading = true;
    });
    if (_patientId.text.isNotEmpty || _patientId.text != '') {
      PhysicalStat physicalstst = PhysicalStat(
        patientId: int.parse(_patientId.text),
        anemia: anemia,
        appearance: _appearance.text,
        bloodPressureDiastolic: _bloodPressureDiastolic.text,
        bloodPressureSystolic: _bloodPressuresystolic.text,
        bodyTemparature: _bodytemparature.text,
        cyanosis: cyanosis,
        dehydration: dehydration,
        edema: edema,
        heightFeet: heightFeet,
        heightInches: heightInch,
        jaundice: jaundice,
        pulseRate: _pulseRate.text.isNotEmpty ? int.parse(_pulseRate.text) : 0,
        rbsFbs: _rbsFbs.text,
        spO2: _spo2.text.isNotEmpty ? int.parse(_spo2.text) : 0,
        weight: _weight.text.isNotEmpty ? int.parse(_weight.text) : 0,
      );

      int prescriptionId = await dbProvider?.createPhysicalStat(physicalstst);
      print(prescriptionId);

      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, "/physicalstat");
    } else {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Please Input Patient Id")));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    var container = Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(width: 5, color: Colors.grey)),
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MultilineTextField(
            minLines: 1,
            controller: _patientId,
            hintText: 'Patient Id',
            isKeyboardNumber: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Height : '),
              SizedBox(
                width: 150,
                child: DropdownButton<int>(
                  hint: const Text('Feet  '),
                  value: heightFeet,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      heightFeet = newValue!;
                    });
                  },
                  items:
                      <int>[...heightf].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 150,
                child: DropdownButton<int>(
                  hint: const Text('Inch  '),
                  value: heightInch,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      heightInch = newValue!;
                    });
                  },
                  items: <int>[...heightin]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: MultilineTextField(
                    minLines: 1,
                    controller: _bodytemparature,
                    hintText: 'Body Temparature'),
              ),
              SizedBox(
                width: 150,
                child: MultilineTextField(
                    minLines: 1,
                    controller: _appearance,
                    hintText: 'Appearance'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  hint: const Text('Anemia'),
                  value: anemia,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      anemia = newValue!;
                    });
                  },
                  items: <String>[...isPositive]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  hint: const Text('Jaundice'),
                  value: jaundice,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      jaundice = newValue!;
                    });
                  },
                  items: <String>[...isPositive]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  hint: const Text('Dehydration'),
                  value: dehydration,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dehydration = newValue!;
                    });
                  },
                  items: <String>[...isPositive]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  hint: const Text('Edema'),
                  value: edema,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      edema = newValue!;
                    });
                  },
                  items: <String>[...isPositive]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: DropdownButton<String>(
                  hint: const Text('Cyanosis'),
                  value: cyanosis,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      cyanosis = newValue!;
                    });
                  },
                  items: <String>[...isPositive]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 150,
                child: MultilineTextField(
                    minLines: 1, controller: _rbsFbs, hintText: 'RBS/FBS'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Blood Pressure:'),
              SizedBox(
                width: 100,
                child: MultilineTextField(
                    isKeyboardNumber: true,
                    minLines: 1,
                    controller: _bloodPressuresystolic,
                    hintText: 'Systolic'),
              ),
              SizedBox(
                width: 100,
                child: MultilineTextField(
                    isKeyboardNumber: true,
                    minLines: 1,
                    controller: _bloodPressureDiastolic,
                    hintText: 'Diastolic'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: MultilineTextField(
                    isKeyboardNumber: true,
                    minLines: 1,
                    controller: _pulseRate,
                    hintText: 'Pulse Rate'),
              ),
              SizedBox(
                width: 150,
                child: MultilineTextField(
                    isKeyboardNumber: true,
                    minLines: 1,
                    controller: _spo2,
                    hintText: 'spo2'),
              ),
            ],
          ),
        ],
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Physical Stat'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    container,
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Button(
                              addData: () {
                                Navigator.pushReplacementNamed(
                                    context, "/physicalstat");
                              },
                              icon: Icons.arrow_back,
                              text: "Back"),
                          Button(
                              addData: () {
                                _savePhysicalStatToLocalDb();
                              },
                              icon: Icons.save,
                              text: "Save"),
                        ],
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}
