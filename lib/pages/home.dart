import 'package:flutter/material.dart';

import '../providers/db_provider.dart';
import '../utils/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBProvider? _dbProvider;
  @override
  void initState() {
    super.initState();
    _dbProvider = DBProvider.db;
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
        title: const Text("HOME"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: const AppDrawer(),
      body: Container(
        child: Text("HOME PAGE"),
      ),
    );
  }
}
