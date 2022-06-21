import 'package:flutter/material.dart';

import '../../providers/apiProvider/api_provider.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';
import '../../widgets/data_sync_wid.dart';

class DataSync extends StatefulWidget {
  const DataSync({Key? key}) : super(key: key);

  @override
  State<DataSync> createState() => _DataSyncState();
}

class _DataSyncState extends State<DataSync> {
  var hospitalcount = "";
  var divisionCount = "";
  var districtCount = "";
  var upazilaCount = "";
  var userCount = "";
  var diseaseCategoryCount = "";
  var diseaseCount = "";
  var medicineCount = "";
  DBProvider? dbProvider;
  @override
  void initState() {
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
    var totalUser = await dbProvider?.getUserCount();

    var totaldiseaseCategory = await dbProvider?.getDiseaseCategoryCount();
    var totalDisease = await dbProvider?.getDiseaseCount();
    var totalMedicine = await dbProvider?.getMedicineCount();
    setState(() {
      hospitalcount = totalHospital.toString();
      divisionCount = totalDivision.toString();
      districtCount = totalDistrict.toString();
      upazilaCount = totalUpazila.toString();
      userCount = totalUser.toString();
      diseaseCategoryCount = totaldiseaseCategory.toString();
      diseaseCount = totalDisease.toString();
      medicineCount = totalMedicine.toString();
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
                DataSyncWidget(
                    count: hospitalcount,
                    title: "Hospital",
                    loadData: () {
                      _loadHospital();
                    }),
                DataSyncWidget(
                    count: divisionCount,
                    title: "Division",
                    loadData: () {
                      _loadDivision();
                    }),
                DataSyncWidget(
                    count: districtCount,
                    title: "District",
                    loadData: () {
                      _loadDistrict();
                    }),
                DataSyncWidget(
                    count: upazilaCount,
                    title: "Upazila",
                    loadData: () {
                      _loadUpazila();
                    }),
                DataSyncWidget(
                    count: userCount,
                    title: "Doctor",
                    loadData: () {
                      _loadUser();
                    }),
                DataSyncWidget(
                    count: diseaseCategoryCount,
                    title: "Disease Category",
                    loadData: () {
                      _loadDiseaseCategory();
                    }),
                DataSyncWidget(
                    count: diseaseCount,
                    title: "Disease",
                    loadData: () {
                      _loadDisease();
                    }),
                DataSyncWidget(
                    count: medicineCount,
                    title: "Medicine",
                    loadData: () {
                      _loadMedicine();
                    }),
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
    await _refreshCount();
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
    await _refreshCount();
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
    await _refreshCount();
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
    await _refreshCount();
    setState(() {
      isLoading = false;
    });
  }

  _loadUser() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllUser();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
    await _refreshCount();
    setState(() {
      isLoading = false;
    });
  }

  _loadDiseaseCategory() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllDiseaseCategory();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
    await _refreshCount();
    setState(() {
      isLoading = false;
    });
  }

  _loadDisease() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllDisease();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
    await _refreshCount();
    setState(() {
      isLoading = false;
    });
  }

  _loadMedicine() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = ApiProvider();
    await apiProvider.getAllMedicine();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));
    await _refreshCount();
    setState(() {
      isLoading = false;
    });
  }
}
