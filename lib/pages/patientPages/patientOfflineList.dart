import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/patientOfflineModel.dart';
import '../../Models/response.dart';
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
  HasNetWork hasNetWork = HasNetWork();
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    loadPatient();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DataTable(
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
                                icon: const Icon(
                                  Icons.send,
                                ),
                                iconSize: 25,
                                color: Colors.blue,
                                splashColor: Colors.purple,
                                onPressed: () {
                                  _showMyDialog(e.id);
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
                          DataCell(Text('No Data')),
                          DataCell(Text('************')),
                        ],
                      ),
                    ]),
    );
  }

  loadPatient() async {
    setState(() {
      isLoading = true;
    });
    patients = [];

    List<PatientOfflineModel> totalPatient = await dbProvider?.getAllPatient();
    if (totalPatient.isNotEmpty) {
      setState(() {
        patients = totalPatient;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  deletePatient(int id) async {
    var deletePatient = await dbProvider?.deletePatient(id);
    loadPatient();
    return deletePatient;
  }

  sendPatientToOnline(int id) async {
    bool isOnline = await hasNetWork.hasNetwork();
    if (isOnline) {
      setState(() {
        isLoading = true;
      });
      List<PatientOfflineModel> totalPatient = await dbProvider?.getPatient(id);
      if (totalPatient.isNotEmpty) {
        PatientOfflineModel patient = totalPatient[0];
        var data = jsonEncode(patient);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final String? token = preferences.getString("token");
        if (token == null) {
          Navigator.pushReplacementNamed(context, "/login");
          scaffoldMessenger
              .showSnackBar(const SnackBar(content: Text("Please Login")));
        } else {
          try {
            final response = await http.post(Uri.parse(PATIENTURI),
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                  "Authorization": 'Bearer $token',
                },
                body: data,
                encoding: Encoding.getByName("utf-8"));
            if (response.statusCode == 200) {
              Map<String, dynamic> resposne = jsonDecode(response.body);
              var responseData = ResponseData.fromJson(resposne);
              if (responseData.message == "success") {
                await deletePatient(id);
                await _showDialogWithPatientId(responseData.data!);
              }
              if (resposne.isNotEmpty) {
                scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("${resposne['message']}")));
                //delete Patient from Offline
                // Navigator.pushReplacementNamed(context, "/patientlist");
                // setState(() {});
              } else {
                scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("${resposne['message']}")));
              }
            } else {
              scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text("${response.statusCode}")));
            }
            setState(() {
              isLoading = false;
            });
          } catch (error) {
            scaffoldMessenger
                .showSnackBar(SnackBar(content: Text(error.toString())));
          }
        }
      }
    } else {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text(" Please check Your Connection !")));
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Online'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Send To Online'),
                Text('Are you sure send data to online ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                sendPatientToOnline(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogWithPatientId(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Patient Id :' + id),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
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
