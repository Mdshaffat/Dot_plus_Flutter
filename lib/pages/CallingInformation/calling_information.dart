import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/Models/callinginfoofflinemodel.dart';
import 'package:intl/intl.dart';

import '../../API/api.dart';
import '../../Models/callinginfo.dart';
import '../../Models/response.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class CallingInformation extends StatefulWidget {
  const CallingInformation({Key? key}) : super(key: key);

  @override
  State<CallingInformation> createState() => _CallingInformationState();
}

class _CallingInformationState extends State<CallingInformation> {
  List<CallingInfoOffline> _callinfo = [];
  List<String> str = [];
  DBProvider? dbProvider;
  HasNetWork hasNetWork = HasNetWork();
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    sendCallingInfoToOnline();
    loadCallingInfo();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Info"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            tooltip: 'Open shopping cart',
            onPressed: () {
              sendCallingInfoToOnline();
            },
          ),
        ],
      ),
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
                          'Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Updated',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  rows: _callinfo.length > 0
                      ? _callinfo
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(e.receiverFirstName.toString() +
                                    " " +
                                    e.receiverLastName.toString())),
                                DataCell(Text(DateFormat("hh:mm a - dd MMM yyy")
                                    .format(DateTime.parse(e.callingTime!)))),
                                DataCell(Checkbox(
                                  checkColor: Colors.blue,
                                  activeColor: Colors.blue,
                                  value: e.status == 0 ? false : true,
                                  onChanged: (bool? value) {},
                                )),
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
                        ])),
    );
  }

  loadCallingInfo() async {
    isLoading = true;
    List<CallingInfoOffline> infolist = [];
    _callinfo = [];
    List<CallingInfoOffline> totalCallInfo = await dbProvider?.getAllCallInfo();
    if (totalCallInfo.isNotEmpty) {
      setState(() {
        _callinfo = totalCallInfo;
        isLoading = false;
      });
    } else {
      setState(() {
        _callinfo = [];
        isLoading = false;
      });
    }
  }

  deleteCallHistory(int id) async {
    var deletePatient = await dbProvider?.deletePatient(id);
    loadCallingInfo();
    return deletePatient;
  }

  sendCallingInfoToOnline() async {
    isLoading = true;
    var _isOnline = await hasNetWork.hasNetwork();
    if (_isOnline) {
      List<CallingInfo> allCallingInfo = await dbProvider?.getUnSyncCallInfo();
      if (allCallingInfo.isNotEmpty) {
        for (var callingInfo in allCallingInfo) {
          Response response;
          var dio = Dio();
          var data = jsonEncode(callingInfo);
          response = await dio.post(TELEMEDICINEURI, data: data);
          if (response.statusCode == 200) {
            var updateStatus =
                await dbProvider?.updateCallStatus(callingInfo.id);
            if (updateStatus != null) {
              scaffoldMessenger
                  .showSnackBar(const SnackBar(content: Text("Updated")));
            } else {
              continue;
            }
          }
        }
        setState(() {
          loadCallingInfo();
        });
      }
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Updated")));
    } else {
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Offline")));
    }
    setState(() {
      isLoading = false;
    });
  }
}
