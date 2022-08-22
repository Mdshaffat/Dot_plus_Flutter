import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/Models/physicalStatModel/physical_stat.dart';
import 'package:hospital_app/pages/physicalstatpages/add_physical_stat.dart';
import 'package:hospital_app/pages/physicalstatpages/physical_stat_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/response.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class PhysicalStatOfflineList extends StatefulWidget {
  const PhysicalStatOfflineList({Key? key}) : super(key: key);

  @override
  State<PhysicalStatOfflineList> createState() =>
      _PhysicalStatOfflineListState();
}

class _PhysicalStatOfflineListState extends State<PhysicalStatOfflineList> {
  Paginations? paginations;
  List<PhysicalStat> physicalStats = [];
  List<String> str = [];
  DBProvider? dbProvider;
  HasNetWork hasNetWork = HasNetWork();
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    loadPhysicalStat();
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const PhysicalStatAdd())));
        },
      ),
      appBar: AppBar(
        title: const Text("PhysicalStat Offline List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : DataTable(
                  columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Patient Id',
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
                  rows: physicalStats.isNotEmpty
                      ? physicalStats
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(e.patientId.toString())),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.info,
                                        ),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        splashColor: Colors.purple,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhysicalSatDetails(
                                                        physicalStat: e,
                                                      )));
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.send,
                                        ),
                                        iconSize: 25,
                                        color: Colors.blue,
                                        splashColor: Colors.purple,
                                        onPressed: () {
                                          _showMyDialog(e.id!);
                                        },
                                      ),
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
                              DataCell(Text('************')),
                            ],
                          ),
                        ])),
    );
  }

  loadPhysicalStat() async {
    isLoading = true;
    try {
      physicalStats = [];
      List<PhysicalStat> totalPhysicalStat =
          await dbProvider?.getAllPhysicalStat();
      if (totalPhysicalStat.isNotEmpty) {
        setState(() {
          physicalStats = totalPhysicalStat;
          isLoading = false;
        });
      } else {
        setState(() {
          physicalStats = [];
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        physicalStats = [];
        isLoading = false;
      });
    }
  }

  deletePhysicalStat(int id) async {
    var deletePatient = await dbProvider?.deletePhysicalStatById(id);
    loadPhysicalStat();
    return deletePatient;
  }

  sendPhysicalStatOnline(int id) async {
    bool isOnline = await hasNetWork.hasNetwork();
    if (isOnline) {
      setState(() {
        isLoading = true;
      });
      List<PhysicalStat> totalPhysicalStat =
          await dbProvider?.getPhysicalStatById(id);

      if (totalPhysicalStat.isNotEmpty) {
        PhysicalStat physicalstat = totalPhysicalStat[0];
        var data = jsonEncode(physicalstat);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final String? token = preferences.getString("token");
        if (token == null) {
          Navigator.pushReplacementNamed(context, "/login");
          scaffoldMessenger
              .showSnackBar(const SnackBar(content: Text("Please Login")));
        } else {
          try {
            final response = await http.post(Uri.parse(PHYSICALSTATURI),
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
                await deletePhysicalStat(id);
              }
              if (resposne.isNotEmpty) {
                scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("${resposne['message']}")));
              }
            } else {
              Map<String, dynamic> resposne = jsonDecode(response.body);
              scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text("${resposne['message']}")));
            }
          } catch (error) {
            scaffoldMessenger
                .showSnackBar(const SnackBar(content: Text("Error to send")));
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
                sendPhysicalStatOnline(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
