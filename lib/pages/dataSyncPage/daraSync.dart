import 'package:flutter/material.dart';

import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class DataSync extends StatefulWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  var count;
  DBProvider? dbProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbProvider = DBProvider.db;
    setState(() {});
  }

  _refreshContactList() async {
    var totalHospital = await dbProvider?.getHospitalCount();
    setState(() {
      count = totalHospital.toString();
    });
  }

  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sync Data"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/patientlist"),
          )),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: InkWell(
                      // focusColor: Colors.black,
                      // highlightColor: Colors.black,
                      // hoverColor: Colors.black,
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        _refreshContactList();
                        debugPrint('Card tapped.');
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sync Hospital",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              count ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
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
