import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/response.dart';
import '../../utils/app_drawer.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController _patientIdController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  Paginations? paginations;
  List<String> str = [];
  List<User> _users = [];
  HasNetWork hasNetWork = HasNetWork();
  bool isOnline = false;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _isOnlineAwaiter();
    setState(() {});
  }

  _isOnline() async {
    var _isOnline = await hasNetWork.hasNetwork();
    isOnline = _isOnline;
    if (isOnline) {
      loadUsers();
    }
  }

  _isOnlineAwaiter() async {
    await _isOnline();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Telemedicine"),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
          child: DataTable(
              columns: const <DataColumn>[
            // DataColumn(
            //   label: Text(
            //     'Designation',
            //     style: TextStyle(fontStyle: FontStyle.italic),
            //   ),
            // ),
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
                'Call',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
              rows: _users.isNotEmpty
                  ? _users
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            // DataCell(Text(e.designation.toString())),
                            DataCell(Text(e.firstName.toString() +
                                " " +
                                e.lastName.toString())),
                            DataCell(Text(e.phoneNumber.toString())),
                            DataCell(
                              IconButton(
                                icon: const Icon(
                                  Icons.phone,
                                ),
                                iconSize: 25,
                                color: Colors.blue,
                                splashColor: Colors.purple,
                                onPressed: () {
                                  _showCallingDialog(e.userId.toString(),
                                      e.phoneNumber.toString());
                                  // _callNumber(e.phoneNumber.toString());
                                  // _showMyDialog(e.id);
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
                          DataCell(Text('Offline')),
                          DataCell(Text('************')),
                        ],
                      ),
                    ])),
    );
  }

  loadUsers() async {
    List<User> users = [];
    final response = await http.get(Uri.parse(USERS));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonresponse = jsonDecode(response.body);
      for (var item in jsonresponse) {
        users.add(User.fromJson(item));
      }
      _users = users;
      setState(() {});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<bool?> _callNumber(String phoneNumber) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? userId = preferences.getString("id");
    String number = phoneNumber;
    var call = await FlutterPhoneDirectCaller.callNumber(number);
    return call;
  }

  _sendCallingInfo(
    String doctorId,
    String phoneNumber,
    int patientId,
    BuildContext context,
  ) async {
    if (_patientIdController.text.isEmpty ||
        _patientIdController.text == " " ||
        _patientIdController.text == "") {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Please Fill Patient ID")));
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? userId = preferences.getString("id");
      var data = jsonEncode(
          {"patietnId": patientId, "callerId": userId, "receiverId": doctorId});

      Response response;
      var dio = Dio();
      response = await dio.post(TELEMEDICINEURI, data: data);
      if (response.statusCode == 200) {
        var callSuccess = await _callNumber(phoneNumber);
        if (callSuccess == false || callSuccess == null) {
          scaffoldMessenger
              .showSnackBar(const SnackBar(content: Text("Faild to call")));
        } else {
          scaffoldMessenger
              .showSnackBar(const SnackBar(content: Text("Calling....")));
          Navigator.of(context).pop();
        }
      }
    }
  }

  Future<void> _showCallingDialog(String doctorId, String phoneNumber) async {
    _patientIdController = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Online'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter Patient ID'),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: TextFormField(
                      controller: _patientIdController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Enter Patient ID",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ),
                  ),
                ),
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
            IconButton(
              icon: const Icon(
                Icons.phone,
              ),
              iconSize: 25,
              color: Colors.blue,
              splashColor: Colors.purple,
              onPressed: () {
                if (_patientIdController.text.isEmpty ||
                    _patientIdController.text == " " ||
                    _patientIdController.text == "") {
                  scaffoldMessenger.showSnackBar(const SnackBar(
                      content: Text("Please Fill Patient ID Properly")));
                } else {
                  _sendCallingInfo(doctorId, phoneNumber,
                      int.parse(_patientIdController.text), context);
                }
                // _showMyDialog(e.id);
              },
            ),
          ],
        );
      },
    );
  }
}
