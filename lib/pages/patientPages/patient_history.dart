import 'package:flutter/material.dart';

import '../../Models/QRModel/patient_qr_info.dart';

class PatientHistory extends StatefulWidget {
  PatientQRInfo patientQRInfo;
  PatientHistory({Key? key, required this.patientQRInfo}) : super(key: key);

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Patient ID : ${widget.patientQRInfo.id}"),
        Text(
            "Patient Name : ${widget.patientQRInfo.firstname} ${widget.patientQRInfo.lastname}"),
        Text("Patient Mobile :  ${widget.patientQRInfo.mobileNumber}"),
      ],
    )));
  }
}
