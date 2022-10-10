import 'package:flutter/material.dart';
import 'package:hospital_app/pages/prescriptionpages/prescription_page.dart';
import 'package:hospital_app/utils/app_drawer.dart';
import 'package:hospital_app/widgets/multiline_text_field.dart';

import '../../../Models/hospital.dart';
import '../../../providers/db_provider.dart';

class AddPrescriptionFromQRDetails extends StatefulWidget {
  final String patientID;
  const AddPrescriptionFromQRDetails({Key? key, required this.patientID})
      : super(key: key);

  @override
  State<AddPrescriptionFromQRDetails> createState() =>
      _AddPrescriptionFromQRDetailsState();
}

class _AddPrescriptionFromQRDetailsState
    extends State<AddPrescriptionFromQRDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientId = TextEditingController();
  int? hospitalId;
  int? branchId;
  Hospital? hospital;
  List<Hospital> _hospitals = [];
  DBProvider? dbProvider;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    fetchHospitals();
    patchPatientID();
  }

  patchPatientID() {
    setState(() {
      _patientId.text = widget.patientID.toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _patientId.dispose();
  }

  // fatch Hospital
  fetchHospitals() async {
    List<Hospital> totalHospital = await dbProvider?.getAllHospital();
    if (totalHospital.length > 1) {
      setState(() {
        _hospitals = totalHospital;
      });
    } else {
      _hospitals = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Prescription'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Prescription',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                  height: 100,
                  width: 200,
                  child: MultilineTextField(
                    isKeyboardNumber: true,
                    hintText: "Patient Id",
                    minLines: 1,
                    controller: _patientId,
                  )),
              DropdownButton<Hospital>(
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (Hospital? newValue) {
                  setState(() {
                    hospital = newValue;
                    hospitalId = newValue!.id;
                    branchId = newValue.branchId;
                  });
                },
                items:
                    _hospitals.map<DropdownMenuItem<Hospital>>((Hospital item) {
                  return DropdownMenuItem<Hospital>(
                    child: Text(item.name ?? "Unknown"),
                    value: item,
                  );
                }).toList(),
                value: hospital,
                hint: const Text("Hospital Name"),
              ),
              TextButton(
                  onPressed: () {
                    if (hospitalId != null &&
                        branchId != null &&
                        _patientId.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrescriptionPage(
                                patientId: int.parse(_patientId.text),
                                hospitalId: hospitalId!,
                                branchId: branchId!)),
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Please Fill up Patient Id and Select Branch'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    child: const Center(
                      child: Text(
                        'Next Page',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
