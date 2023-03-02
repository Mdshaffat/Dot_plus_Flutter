import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/pages/patientPages/patient_online_details.dart';
import 'package:hospital_app/pages/patientPages/patient_online_edit.dart';
import 'package:hospital_app/pages/QR%20code%20scanner/scan_qr_code.dart';
import 'package:http/http.dart' as http;

import '../../Models/response.dart';
import '../../utils/app_drawer.dart';
import 'Online/patientDetails.dart';
import 'Online/patientEdit.dart';
import 'Online/patienthistoryfrontpage.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  Paginations? paginations;
  List<String> str = [];
  HasNetWork hasNetWork = HasNetWork();
  bool isOnline = false;
  @override
  initState() {
    super.initState();
    _isOnlineAwaiter();
    setState(() {});
  }

  _isOnline() async {
    var _isOnline = await hasNetWork.hasNetwork();
    isOnline = _isOnline;
    if (isOnline) {
      loadPatient();
    }
  }

  _isOnlineAwaiter() async {
    await _isOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Patient Online',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PatientOnlineEdit()),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'View Patient Online',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PatientOnlineDetails()),
                ),
              );
            },
          ),
          // history
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View Patient History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => PatientHistoryFrontPage()),
                ),
              );
            },
          ),

          // QR Code Scan
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Scan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const ScanQRCode()),
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'NAME',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mobile',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: paginations != null
                  ? paginations!.data
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(e.id.toString())),
                            DataCell(Text(e.firstName.toString() +
                                " " +
                                e.lastName.toString())),
                            DataCell(Text(e.mobileNumber.toString())),
                            DataCell(
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  PatientOnlineDetailsFromTable(
                                                      patientId: e.id))));
                                    },
                                    child: Icon(Icons.info),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  PatientOnlineEditFromTable(
                                                      id: e.id))));
                                    },
                                    child: Icon(Icons.edit),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList()
                  : <DataRow>[
                      const DataRow(
                        cells: <DataCell>[
                          DataCell(Text('0')),
                          DataCell(Text('Offline')),
                          DataCell(Text('****')),
                          DataCell(Text('******')),
                        ],
                      ),
                    ]),
        ),
      ),
    );
  }

  loadPatient() async {
    Paginations? pagination;
    final response = await http.get(Uri.parse(PATIENTURI));

    if (response.statusCode == 200) {
      var jsonresponse = jsonDecode(response.body);
      // print(jsonresponse);
      if (jsonresponse != null) {
        pagination = Paginations.fromJson(jsonresponse);
        paginations = pagination;
        setState(() {});
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
