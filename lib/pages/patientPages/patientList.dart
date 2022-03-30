import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_drawer.dart';

class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  Paginations? paginations;
  List<String> str = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadPatient();
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
        title: const Text("Patient List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
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
