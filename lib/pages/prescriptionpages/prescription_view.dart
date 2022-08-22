import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/api.dart';
import '../../Models/prescription_model/prescription_online.dart';
import '../../providers/db_provider.dart';
import '../../widgets/RoundedButton.dart';
import '../../widgets/read_only_text_fiels.dart';

class PrescriptionOnlineView extends StatefulWidget {
  const PrescriptionOnlineView({Key? key}) : super(key: key);

  @override
  State<PrescriptionOnlineView> createState() => _PrescriptionOnlineViewState();
}

class _PrescriptionOnlineViewState extends State<PrescriptionOnlineView> {
  int? id;
  PrescriptionOnline? prescription;
  List<Diagnosis> diagnosis = [];
  List<MedicineForPrescription> medicineForPrescription = [];
  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  DBProvider? dbProvider;

  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    getDiagnosis();
  }

  getDiagnosis() async {
    if (prescription != null) {
      for (var element in prescription!.medicineForPrescription!) {
        medicineForPrescription.add(element);
      }
      for (var element in prescription!.diagnosis!) {
        diagnosis.add(element);
      }
    }
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      doctorfirstName = preferences.getString("firstName");
      doctorLastName = preferences.getString("lastName");
    });
  }

  getPrescriptionData(int? id) async {
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
      Response response = await Dio().get(PRESCRIPTIONURI + "/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        prescription = PrescriptionOnline.fromJson(response.data);

        for (var element in prescription!.medicineForPrescription!) {
          medicineForPrescription.add(element);
        }
        for (var element in prescription!.diagnosis!) {
          diagnosis.add(element);
        }
      }
    } catch (data) {
      print(data.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var leftsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          ReadOnlyTextField(
            initialValue: prescription?.doctorsObservation,
            hintText: 'Cc',
            minLines: 6,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.systemicExamination,
            hintText: 'Systemic Examination',
            minLines: 5,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.oh,
            hintText: 'OB-gyn/H',
            minLines: 4,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.historyOfPastIllness,
            hintText: 'History of Past Illness',
            minLines: 3,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.familyHistory,
            hintText: 'Family History',
            minLines: 3,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.allergicHistory,
            hintText: 'Allergic History',
            minLines: 2,
          ),
          ReadOnlyTextField(
            initialValue: prescription?.adviceTest,
            hintText: 'Investigation',
            minLines: 5,
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
                      Text(
                        diagnosis[item].diseases!.name.toString(),
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
                    ],
                  ));
                }),
          ),
          ReadOnlyTextField(
            initialValue: prescription?.note,
            hintText: 'Advice',
            minLines: 5,
          ),
          Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text('Next Visit'),
                  Text((prescription?.nextVisit == null)
                      ? 'No Visit Next'
                      : DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(prescription!.nextVisit.toString()))),
                ],
              ),
              Row(
                children: [
                  const Text('Telemedicine'),
                  Checkbox(
                    checkColor: const Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.blue,
                    value: prescription?.isTelimedicine != null
                        ? prescription?.isTelimedicine
                        : false,
                    onChanged: (bool? value) {},
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Afternoon'),
                  Checkbox(
                    checkColor: const Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.blue,
                    value: prescription?.isAfternoon != null
                        ? prescription?.isAfternoon
                        : false,
                    onChanged: (bool? value) {},
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
              Text(
                  "Prescribed By: ${prescription?.doctorFirstName} ${prescription?.doctorLastName}"),
              Row(
                children: [
                  const Text('Hospital: '),
                  Text('${prescription?.hospitalName}'),
                ],
              )
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Name: '),
                      Text(
                          '${prescription?.patientFirstName} ${prescription?.patientLastName}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Age: '),
                      Text('${prescription?.patientAge}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Gender: '),
                      Text('${prescription?.patientGender}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Blood G.: '),
                      Text('${prescription?.patientBloodGroup}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Date: '),
                      Text('${prescription?.createdOn}'),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: 700,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('H: '),
                      Text(
                          '${prescription?.physicalStat?.heightFeet} feet ${prescription?.physicalStat?.heightInches} inch'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Weight: '),
                      Text('${prescription?.physicalStat?.weight}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('Temp: '),
                      Text('${prescription?.physicalStat?.bodyTemparature}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('BMI.: '),
                      Text('${prescription?.physicalStat?.bmi}'),
                      const SizedBox(
                        width: 25,
                      ),
                      const Text('BP: '),
                      Text(
                          '${prescription?.physicalStat?.bloodPressureDiastolic}/${prescription?.physicalStat?.bloodPressureSystolic}'),
                    ],
                  ),
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
                        addData: () async {}, icon: Icons.save, text: "Print"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 200,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(fontSize: 14.0),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 3.0),
                                          ),
                                          hintText: 'Prescription ID',
                                          hintStyle: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        ),
                                        onChanged: ((value) {
                                          id = int.parse(value);
                                        }),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 50),
                                      child: Button(
                                        icon: Icons.search,
                                        text: 'Search',
                                        addData: () {
                                          getPrescriptionData(id);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      if (prescription != null) virticalScroolView,
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
