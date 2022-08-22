import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/diseaseAndMedicine/diagnosis.dart';
import '../../Models/diseaseAndMedicine/medicine_for_prescription.dart';
import '../../Models/prescription_model/prescription_dto.dart';
import '../../providers/db_provider.dart';
import '../../widgets/RoundedButton.dart';
import '../../widgets/read_only_text_fiels.dart';

class PrescriptionDetails extends StatefulWidget {
  final PrescriptionDto prescription;
  const PrescriptionDetails({Key? key, required this.prescription})
      : super(key: key);

  @override
  State<PrescriptionDetails> createState() => _PrescriptionDetailsState();
}

class _PrescriptionDetailsState extends State<PrescriptionDetails> {
  List<Diagnosis> diagnosis = [];
  List<MedicineForPrescription> medicineForPrescription = [];
  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';
  final _formKey = GlobalKey<FormState>();

  DBProvider? dbProvider;

  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    getdata();
    getDiagnosis();
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

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      doctorfirstName = preferences.getString("firstName");
      doctorLastName = preferences.getString("lastName");
    });
  }

  getMedicine() {}

  @override
  Widget build(BuildContext context) {
    var leftsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          ReadOnlyTextField(
            initialValue: widget.prescription.doctorsObservation,
            hintText: 'Cc',
            minLines: 6,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.systemicExamination,
            hintText: 'Systemic Examination',
            minLines: 5,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.oh,
            hintText: 'OB-gyn/H',
            minLines: 4,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.historyOfPastIllness,
            hintText: 'History of Past Illness',
            minLines: 3,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.familyHistory,
            hintText: 'Family History',
            minLines: 3,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.allergicHistory,
            hintText: 'Allergic History',
            minLines: 2,
          ),
          ReadOnlyTextField(
            initialValue: widget.prescription.adviceTest,
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
            initialValue: widget.prescription.note,
            hintText: 'Advice',
            minLines: 5,
          ),
          Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text('Next Visit'),
                  Text((widget.prescription.nextVisit == 'null' ||
                          widget.prescription.nextVisit == null)
                      ? 'No Visit Next'
                      : DateFormat('dd-MM-yyyy').format(
                          DateTime.parse(widget.prescription.nextVisit!))),
                ],
              ),
              Row(
                children: [
                  const Text('Telemedicine'),
                  Checkbox(
                    checkColor: const Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.blue,
                    value:
                        widget.prescription.isTelimedicine == 1 ? true : false,
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
                    value: widget.prescription.isAfternoon == 1 ? true : false,
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
                  Text(widget.prescription.patientId.toString()),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text('Hospital ID: '),
                  Text(widget.prescription.hospitalId.toString()),
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
