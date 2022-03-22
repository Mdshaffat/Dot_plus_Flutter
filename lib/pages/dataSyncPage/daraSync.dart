import 'package:flutter/material.dart';

import '../../utils/app_drawer.dart';

class DataSync extends StatelessWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sync Data"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/patientlist"),
          )),
      drawer: AppDrawer(),
      body: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                // hoverColor: Colors.black,
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    'Sync Hospital',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                // hoverColor: Colors.black,
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    'Sync Branch',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                // hoverColor: Colors.black,
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    'Sync Division',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                // hoverColor: Colors.black,
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    'Sync District',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: InkWell(
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                // hoverColor: Colors.black,
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    'Sync Upazila',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
