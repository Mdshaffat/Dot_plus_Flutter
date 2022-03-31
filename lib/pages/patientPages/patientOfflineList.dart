import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/Models/patientAdd.dart';
import 'package:hospital_app/pages/patientPages/patientAdd.dart';
import 'package:http/http.dart' as http;

import '../../Models/patientOfflineModel.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class PatientOfflineList extends StatefulWidget {
  const PatientOfflineList({Key? key}) : super(key: key);

  @override
  State<PatientOfflineList> createState() => _PatientOfflineListState();
}

class _PatientOfflineListState extends State<PatientOfflineList> {
  Paginations? paginations;
  List<PatientOfflineModel> patients = [];
  List<String> str = [];
  DBProvider? dbProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbProvider = DBProvider.db;
    loadPatient();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        splashColor: Colors.red,
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/patientadd");
        },
      ),
      appBar: AppBar(
        title: const Text("Patient Offline List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: DataTable(
              columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
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
              rows: patients.length > 0
                  ? patients
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(e.firstName.toString() +
                                " " +
                                e.lastName.toString())),
                            DataCell(Text(e.mobileNumber.toString())),
                            DataCell(
                              IconButton(
                                icon: Icon(
                                  Icons.send,
                                ),
                                iconSize: 25,
                                color: Colors.blue,
                                splashColor: Colors.purple,
                                onPressed: () {
                                  _showMyDialog();
                                },
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
                          DataCell(Text('Unknown')),
                          DataCell(Text('************')),
                        ],
                      ),
                    ])),
    );
  }

  loadPatient() async {
    // Paginations? pagination;
    // final response = await http.get(Uri.parse(PATIENTURI));

    List<PatientOfflineModel> patientlist = [];
    patients = [];
    // final response = await http.get(Uri.parse(DIVISIONURI));

    List<PatientOfflineModel> totalPatient = await dbProvider?.getAllPatient();
    if (totalPatient.length > 1) {
      setState(() {
        patients = totalPatient;
      });
    } else {
      setState(() {
        List<PatientOfflineModel> patientlist = [];
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
