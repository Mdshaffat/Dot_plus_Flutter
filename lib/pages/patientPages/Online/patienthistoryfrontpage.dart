import 'package:flutter/material.dart';
import 'package:hospital_app/Models/QRModel/patient_qr_info.dart';
import 'package:hospital_app/pages/prescriptionpages/prescription_page.dart';
import 'package:hospital_app/utils/app_drawer.dart';
import 'package:hospital_app/widgets/multiline_text_field.dart';

import '../patient_history.dart';

class PatientHistoryFrontPage extends StatefulWidget {
  const PatientHistoryFrontPage({Key? key}) : super(key: key);

  @override
  State<PatientHistoryFrontPage> createState() =>
      _PatientHistoryFrontPageState();
}

class _PatientHistoryFrontPageState extends State<PatientHistoryFrontPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientId = TextEditingController();
  int? hospitalId;
  int? branchId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _patientId.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Patient History'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'View Patient History',
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
              TextButton(
                  onPressed: () {
                    if (_patientId.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientHistory(
                                patientQRInfo: PatientQRInfo(
                                    id: int.parse(_patientId.text)))),
                      );
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Please Fill up Patient Id'),
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
                        'View',
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
