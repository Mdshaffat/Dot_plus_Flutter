import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/diagnosis.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine_for_prescription.dart';
import 'package:hospital_app/Models/prescription_model/prescription_dto.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/diseaseAndMedicine/disease.dart';
import '../../Models/diseaseAndMedicine/diseaseCategory.dart';
import '../../providers/db_provider.dart';
import '../../widgets/RoundedButton.dart';
import '../../widgets/multiline_text_field.dart';

class PrescriptionUpdatePage extends StatefulWidget {
  final PrescriptionDto prescription;
  const PrescriptionUpdatePage({Key? key, required this.prescription})
      : super(key: key);

  @override
  State<PrescriptionUpdatePage> createState() => _PrescriptionUpdatePageState();
}

class _PrescriptionUpdatePageState extends State<PrescriptionUpdatePage> {
  //TextEditingController
  //* CC */
  final TextEditingController _cc =
      TextEditingController(); // doctors observation
  final TextEditingController _systemicExamination = TextEditingController();
  final TextEditingController _obgynHistory = TextEditingController(); //oh
  final TextEditingController _historyofPastIllness = TextEditingController();
  final TextEditingController _familyHistory = TextEditingController();
  final TextEditingController _allergicHistory = TextEditingController();
  final TextEditingController _investigation = TextEditingController();

  //* Rx */
  final TextEditingController _medicineName = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _advice = TextEditingController(); //note

  //DropDown
  DiseaseCategory? diseaseCategory;
  Disease? disease;
  String? medicineDose;
  String? medicinetakingtime;
  Medicine? medicine;

  //DateTime
  DateTime? nextVisit;

  //checkbox
  bool isTelemedicine = false;
  bool isAfternoon = false;

  //Pre inputed data
  int? patientId;
  int? hospitalId;
  int? branchId;
  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';

  //List of *
  List<Diagnosis> diagnosis = [];
  List<MedicineForPrescription> medicineForPrescription = [];
  List<Disease> diseases = [];
  List<DiseaseCategory> diseaseCategories = [];

  // formkey
  final _formKey = GlobalKey<FormState>();

  //* Database Provider */
  DBProvider? dbProvider;
  late ScaffoldMessengerState scaffoldMessenger;
  bool isLoading = false;
  @override
  initState() {
    super.initState();
    dbProvider = DBProvider.db;
    getDoctorsInfo();
    getDiagnosis();
    populetData();
    _getDisease();
  }

  populetData() {
    _cc.text =
        widget.prescription.doctorsObservation ?? ''; // doctors observation
    _systemicExamination.text = widget.prescription.systemicExamination ?? '';
    _obgynHistory.text = widget.prescription.oh ?? ''; //oh
    _historyofPastIllness.text = widget.prescription.historyOfPastIllness ?? '';
    _familyHistory.text = widget.prescription.familyHistory ?? '';
    _allergicHistory.text = widget.prescription.allergicHistory ?? '';
    _investigation.text = widget.prescription.adviceTest ?? '';
    //DateTime
    nextVisit = (widget.prescription.nextVisit == null ||
            widget.prescription.nextVisit == 'null')
        ? null
        : DateTime.parse(widget.prescription.nextVisit.toString());
    //checkbox
    isTelemedicine = widget.prescription.isTelimedicine == 1 ? true : false;
    isAfternoon = widget.prescription.isAfternoon == 1 ? true : false;
  }

  getDiagnosis() async {
    List<MedicineForPrescription> totalMedicinePrescription = await dbProvider
        ?.getMedicineForPrescriptionByPrescriptionId(widget.prescription.id!);
    List<Diagnosis> diagnosisForPrescription =
        await dbProvider?.getDiagnosisForPrescription(widget.prescription.id!);

    setState(() {
      medicineForPrescription = totalMedicinePrescription;
      diagnosis = diagnosisForPrescription;
    });
  }

  _getDiseaseCategoryAndDisease() async {
    // var dis = await dbProvider!.getAllDisease();
    var diseasecat = await dbProvider!.getAllDiseaseCategory();
    setState(() {
      // diseases = dis;
      diseaseCategories = diseasecat;
    });
  }

  _getDiseaseByCategoryId(int id) async {
    var dis = await dbProvider!.getDiseasesAccordinToDiseaseCategory(id);
    setState(() {
      diseases = dis;
    });
  }

  _getDisease() {
    Future.delayed(Duration.zero, () {
      _getDiseaseCategoryAndDisease();
    });
  }

  getDoctorsInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      doctorfirstName = preferences.getString("firstName");
      doctorLastName = preferences.getString("lastName");
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (pickedDate != null && pickedDate != nextVisit) {
      setState(() {
        nextVisit = pickedDate;
      });
    }
  }

  // Preacription Add To Local Db

  _addPrescriptionToLocalDb() async {
    setState(() {
      isLoading = true;
    });
    PrescriptionDto prescription = PrescriptionDto(
        id: widget.prescription.id,
        patientId: widget.prescription.patientId,
        hospitalId: widget.prescription.hospitalId,
        branchId: widget.prescription.branchId,
        adviceTest: _investigation.text,
        allergicHistory: _allergicHistory.text,
        doctorsObservation: _cc.text,
        familyHistory: _familyHistory.text,
        historyOfPastIllness: _historyofPastIllness.text,
        isTelimedicine: isTelemedicine == true ? 1 : 0,
        isAfternoon: isAfternoon == true ? 1 : 0,
        nextVisit: nextVisit == null ? null : nextVisit!.toIso8601String(),
        note: _advice.text,
        oh: _obgynHistory.text,
        systemicExamination: _systemicExamination.text);

    int prescriptionId = await dbProvider?.updatePrescription(prescription);
    if (prescriptionId > 0) {
      // Delete Previous Medicine And Diagnosis
      await dbProvider
          ?.deleteMedicineForPrescriptionByPrescriptionId(prescription.id!);
      await dbProvider?.deleteDiagnosisByPrescriptionId(prescription.id!);

      // Diagnosis Section

      for (var item in diagnosis) {
        Map<String, dynamic> data = {
          'diseasesName': item.diseasesName,
          'diseasesId': item.diseasesId,
          'diseasesCategoryId': item.diseasesCategoryId,
          'prescriptionId': prescriptionId
        };

        await dbProvider!.createDiagnosis(data);
      }

      // Medicine Section

      for (var item in medicineForPrescription) {
        Map<String, dynamic> medicinedata = {
          'brandName': item.brandName,
          'comment': item.comment,
          'dose': item.dose,
          'medicineId': item.medicineId,
          'medicineType': item.medicineType,
          'time': item.time,
          'prescriptionId': prescriptionId
        };
        await dbProvider!.createMedicineForPrescription(medicinedata);
      }

      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, "/prescription");
    } else {
      setState(() {
        isLoading = false;
      });
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Something wrong!!!")));
    }
  }

  @override
  void dispose() {
    _cc.dispose();
    _systemicExamination.dispose();
    _obgynHistory.dispose();
    _historyofPastIllness.dispose();
    _familyHistory.dispose();
    _allergicHistory.dispose();
    _investigation.dispose();
    _medicineName.dispose();
    _comment.dispose();
    _advice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    var leftsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          MultilineTextField(
            controller: _cc,
            hintText: 'Cc',
            minLines: 6,
          ),
          MultilineTextField(
            controller: _systemicExamination,
            hintText: 'Systemic Examination',
            minLines: 5,
          ),
          MultilineTextField(
            controller: _obgynHistory,
            hintText: 'OB-gyn/H',
            minLines: 4,
          ),
          MultilineTextField(
            controller: _historyofPastIllness,
            hintText: 'History of Past Illness',
            minLines: 3,
          ),
          MultilineTextField(
            controller: _familyHistory,
            hintText: 'Family History',
            minLines: 3,
          ),
          MultilineTextField(
            controller: _allergicHistory,
            hintText: 'Allergic History',
            minLines: 2,
          ),
          MultilineTextField(
            controller: _investigation,
            hintText: 'Investigation',
            minLines: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Disease Category'),
              SizedBox(
                height: 50,
                width: 190,
                child: DropdownButton<DiseaseCategory>(
                  isExpanded: true,
                  value: diseaseCategory,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (DiseaseCategory? newValue) {
                    diseaseCategory = newValue!;
                    setState(() {
                      disease = null;
                      diseases = [];
                      _getDiseaseByCategoryId(newValue.id);
                    });
                  },
                  items: <DiseaseCategory>[...diseaseCategories]
                      .map<DropdownMenuItem<DiseaseCategory>>(
                          (DiseaseCategory value) {
                    return DropdownMenuItem<DiseaseCategory>(
                      value: value,
                      child: Text(
                        value.name,
                        overflow: TextOverflow.visible,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const Text('Disease'),
              SizedBox(
                // height: 50,
                width: 190,
                child: DropdownButton<Disease>(
                  isExpanded: true,
                  value: disease,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      overflow: TextOverflow.ellipsis),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (Disease? newValue) {
                    setState(() {
                      disease = newValue;
                      diagnosis.add(Diagnosis(
                          diseasesName: newValue!.name,
                          diseasesId: newValue.id,
                          diseasesCategoryId: newValue.diseasesCategoryId));
                    });
                  },
                  items: <Disease>[...diseases]
                      .map<DropdownMenuItem<Disease>>((Disease value) {
                    return DropdownMenuItem<Disease>(
                      value: value,
                      child: Text(
                        value.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Container(
            width: 200,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: diagnosis.length * 40 + 50,
            child: ListView.builder(
                itemCount: diagnosis.length,
                itemBuilder: (contex, item) {
                  return ListTile(
                      title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (() {
                          setState(() {
                            diagnosis.removeAt(item);
                          });
                        }),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        diagnosis[item].diseasesName,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ));
                }),
          ),
        ],
      ),
    );

    var rightsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text('Search Medicine'),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TypeAheadField<Medicine>(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: _medicineName,
                          autofocus: true,
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 16),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        if (pattern.isEmpty) {
                          return [];
                        }
                        var ex = await dbProvider!.searchMedicine(pattern);
                        return ex;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.brandName!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          medicine = suggestion;
                          _medicineName.text = suggestion.brandName!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Dose'),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton<String>(
                      value: medicineDose,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          medicineDose = newValue!;
                        });
                      },
                      items: <String>[
                        '_',
                        '1+1+1',
                        '1+0+1',
                        '0+0+1',
                        '1+0+0',
                        '0+1+0',
                        '0+1+1',
                        '1+1+1+1',
                        '1+1+0',
                        '2+2+2+2',
                        '2+2+2',
                        '1/2+0+0',
                        '1/2+0+1/2',
                        '1/2+1/2+1/2'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Time'),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton<String>(
                      value: medicinetakingtime,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          medicinetakingtime = newValue!;
                        });
                      },
                      items: <String>['_', 'Before Meal', 'After Meal']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 300,
                child: MultilineTextField(
                  controller: _comment,
                  hintText: 'Comment',
                  minLines: 2,
                ),
              ),
              Button(
                icon: Icons.add,
                text: 'add',
                addData: () {
                  setState(() {
                    medicineForPrescription.add(MedicineForPrescription(
                        medicineId: medicine!.id,
                        medicineType: medicine!.medicineType,
                        brandName: medicine!.brandName,
                        comment: _comment.text,
                        dose: medicineDose,
                        time: medicinetakingtime));

                    _comment.text = '';
                    _medicineName.text = '';
                  });
                },
              ),
            ],
          ),
          Container(
            width: 500,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            height: medicineForPrescription.length * 40 + 200,
            child: ListView.builder(
                itemCount: medicineForPrescription.length,
                itemBuilder: (contex, item) {
                  return ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(medicineForPrescription[item]
                              .medicineType
                              .toString() +
                          '.'),
                      Text(medicineForPrescription[item].brandName.toString()),
                      Text(medicineForPrescription[item].dose.toString()),
                      Text(medicineForPrescription[item].time.toString()),
                      Text(medicineForPrescription[item].comment.toString()),
                      InkWell(
                        onTap: (() {
                          setState(() {
                            medicineForPrescription.removeAt(item);
                          });
                        }),
                        child: const Icon(Icons.delete),
                      )
                    ],
                  ));
                }),
          ),
          MultilineTextField(
            controller: _advice,
            hintText: 'Advice',
            minLines: 5,
          ),
          Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text(nextVisit != null
                      ? DateFormat('dd-MM-yyyy').format(nextVisit!)
                      : 'Pick a Date'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Next Visit'),
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: const Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Telemedicine'),
                  Checkbox(
                    checkColor: const Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.blue,
                    value: isTelemedicine,
                    onChanged: (bool? value) {
                      setState(() {
                        isTelemedicine = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Afternoon'),
                  Checkbox(
                    checkColor: const Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.blue,
                    value: isAfternoon,
                    onChanged: (bool? value) {
                      setState(() {
                        isAfternoon = value!;
                      });
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );

    var _header = SizedBox(
      width: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo/idflogo.jpeg",
            height: 70,
            width: 70,
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Health Program"),
              const Text("Integrated Development Foundation"),
              Text("Prescribed By: $doctorfirstName $doctorLastName"),
            ],
          )
        ],
      ),
    );

    var virticalScroolView = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header,
              Container(
                height: 1,
                width: 700,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Patient ID: '),
                  Text(patientId.toString()),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text('Hospital ID: '),
                  Text(hospitalId.toString()),
                ],
              ),
              Container(
                height: 1,
                width: 700,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    width: 200,
                    child: leftsideScrollView,
                  ),
                  const Divider(
                    thickness: 4.0,
                    color: Colors.blue,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: 500,
                    child: rightsideScrollView,
                  ),
                ],
              ),
              Container(
                height: 1,
                width: 700,
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.grey,
              ),
              SizedBox(
                width: 700,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Button(
                        addData: () {
                          Navigator.pop(context);
                        },
                        icon: Icons.arrow_back,
                        text: "Back"),
                    Button(
                        addData: () async {
                          await _addPrescriptionToLocalDb();
                        },
                        icon: Icons.save,
                        text: "Save"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Form(key: _formKey, child: virticalScroolView),
            ],
          ),
        ),
      ),
    );
  }
}
