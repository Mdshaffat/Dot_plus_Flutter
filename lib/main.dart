import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital_app/pages/FAQ/faq.dart';
import 'package:hospital_app/pages/Users/useList.dart';
import 'package:hospital_app/pages/dataSyncPage/daraSync.dart';
import 'package:hospital_app/pages/home.dart';
import 'package:hospital_app/pages/login.dart';
import 'package:hospital_app/pages/patientPages/patientAdd.dart';
import 'package:hospital_app/pages/patientPages/patientOfflineList.dart';
import 'package:hospital_app/pages/physicalstatpages/physicalstat_list.dart';
import 'package:hospital_app/pages/prescriptionpages/prescriptionList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/CallingInformation/calling_information.dart';
import 'pages/PatientSearchPages/patient_search.dart';
import 'pages/patientPages/patientList.dart';
import 'pages/prescriptionpages/prescription_online_list.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    intGetToken();
  }

  bool isLogedIn = false;
  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString("token");
    if (token != null) {
      if (mounted) {
        setState(() {
          isLogedIn = true;
        });
      }
    } else {
      isLogedIn = false;
    }
  }

  intGetToken() async {
    await getToken();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dot Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: PatientCard(data: "",),
      routes: {
        '/': (context) => isLogedIn ? const Home() : const Login(),
        '/home': (context) => const Home(),
        '/datasync': (context) => const DataSync(),
        '/login': (context) => const Login(),
        '/patientofflinelist': (context) => const PatientOfflineList(),
        '/patientlist': (context) => const PatientList(),
        '/patientadd': (context) => const PatientAdd(),
        '/users': (context) => const UserList(),
        '/callinfo': (context) => const CallingInformation(),
        '/prescription': (context) => const PrescriptionList(),
        '/physicalstat': (context) => const PhysicalStatOfflineList(),
        '/prescriptiononline': (context) => const PrescriptionOnline(),
        '/patientsearch': (context) => const PatientSearch(),
        '/faq': (context) => const FAQ(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
