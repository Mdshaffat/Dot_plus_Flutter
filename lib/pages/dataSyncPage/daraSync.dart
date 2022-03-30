import 'package:flutter/material.dart';

import '../../providers/apiProvider/api_provider.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class DataSync extends StatefulWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  var hospitalcount;
  var divisionCount;
  var districtCount;
  var upazilaCount;
  DBProvider? dbProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbProvider = DBProvider.db;
    _refreshCount();
    setState(() {});
  }

  _refreshCount() async {
    var totalHospital = await dbProvider?.getHospitalCount();
    var totalDivision = await dbProvider?.getDivisionCount();
    var totalDistrict = await dbProvider?.getDistrictCount();
    var totalUpazila = await dbProvider?.getUpazilaCount();
    setState(() {
      hospitalcount = totalHospital.toString();
      divisionCount = totalDivision.toString();
      districtCount = totalDistrict.toString();
      upazilaCount = totalUpazila.toString();
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
                        _loadHospital();
                        _refreshCount();
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
                              hospitalcount ?? '',
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
                        _loadDivision();
                        _refreshCount();
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sync Division",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              divisionCount ?? '',
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
                        _loadDistrict();
                        _refreshCount();
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sync District",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              districtCount ?? '',
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
                        _loadUpazila();
                        _refreshCount();
                      },
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sync Upazila",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              upazilaCount ?? '',
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
              ],
            ),
    );
  }

  _loadHospital() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllHospitals();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _loadDivision() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllDivision();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _loadDistrict() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllDistrict();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _loadUpazila() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllUpazila();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }
}
