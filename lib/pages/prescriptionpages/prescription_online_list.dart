import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:http/http.dart' as http;

import '../../Models/prescription_model/prescription.dart';
import '../../Models/response.dart';
import '../../utils/app_drawer.dart';
import 'add_prescription.dart';

class PrescriptionOnline extends StatefulWidget {
  const PrescriptionOnline({Key? key}) : super(key: key);

  @override
  State<PrescriptionOnline> createState() => _PrescriptionOnlineState();
}

class _PrescriptionOnlineState extends State<PrescriptionOnline> {
  PrescriptionForList? paginations;
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
      loadPrescription();
    }
  }

  _isOnlineAwaiter() async {
    await _isOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        splashColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const AddPrescription())));
        },
      ),
      appBar: AppBar(
        title: const Text("Prescription List"),
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
                            DataCell(Text(e.patientFirstName.toString() +
                                " " +
                                e.patientLastName.toString())),
                            DataCell(Text(e.patientMobile.toString())),
                          ],
                        ),
                      )
                      .toList()
                  : <DataRow>[
                      const DataRow(
                        cells: <DataCell>[
                          DataCell(Text('0')),
                          DataCell(Text('Offline')),
                          DataCell(Text('************')),
                        ],
                      ),
                    ])),
    );
  }

  loadPrescription() async {
    PrescriptionForList? pagination;
    final response = await http.get(Uri.parse(PRESCRIPTIONURI));

    if (response.statusCode == 200) {
      var jsonresponse = jsonDecode(response.body);
      // print(jsonresponse);
      if (jsonresponse != null) {
        pagination = PrescriptionForList.fromJson(jsonresponse);
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
