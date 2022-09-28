import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Models/QRModel/patient_qr_info.dart';
import '../patientPages/patient_history.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _navigateToPatientHistory() {
    if (result != null) {
      PatientQRInfo patientQRInfo = PatientQRInfoFromJson(result!.code ??
          "{'id': 0,'name': 'shaffat','mobileNumber': '01772994301'}");
      if (patientQRInfo.id != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => PatientHistory(
                  patientQRInfo: patientQRInfo,
                )),
          ),
        );
      }
      return;
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? TextButton(
                      onPressed: () {
                        _navigateToPatientHistory();
                      },
                      child: Text('Data: ${result!.code}'),
                    )
                  : const Text('Scanning.....'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
