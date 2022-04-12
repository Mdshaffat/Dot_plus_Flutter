import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/Models/user.dart';
import 'package:http/http.dart' as http;

import '../../Models/response.dart';
import '../../utils/app_drawer.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
        title: const Text("User List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
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
                                  _callNumber(e.phoneNumber.toString());
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
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _callNumber(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
