import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital_app/pages/dataSyncPage/daraSync.dart';
import 'package:hospital_app/pages/home.dart';
import 'package:hospital_app/pages/login.dart';
import 'package:hospital_app/pages/patientPages/patientAdd.dart';
import 'package:hospital_app/pages/patientPages/patientOfflineList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/patientPages/patientList.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dot Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Login(),
      routes: {
        '/': (context) => getToken() == null ? const Login() : Home(),
        '/home': (context) => Home(),
        '/datasync': (context) => const DataSync(),
        '/login': (context) => const Login(),
        '/patientofflinelist': (context) => const PatientOfflineList(),
        '/patientlist': (context) => const PatientList(),
        '/patientadd': (context) => const PatientAdd(),
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

getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? token = preferences.getString("token");
  if (token != null) {
    return token.toString();
  }
  return null;
}
