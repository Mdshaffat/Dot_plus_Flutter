import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/Models/Report/service_count.dart';
import 'package:hospital_app/providers/apiProvider/api_provider.dart';
import 'package:hospital_app/widgets/RoundedButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DBProvider? _dbProvider;
  String greeting = '';
  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';
  DateTime? lastLogin;
  String? token;
  NameWithCount prescriptioncount =
      const NameWithCount(name: '', patientCount: 0);
  NameWithCount patientcount = const NameWithCount(name: '', patientCount: 0);
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    getgreeting();
    getCount();
    // _dbProvider = DBProvider.db;
  }

  getCount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    doctorfirstName = preferences.getString("firstName");
    doctorLastName = preferences.getString("lastName");
    lastLogin =
        DateTime.tryParse(preferences.getString("lastLoginDate").toString())
            ?.add(const Duration(days: 2));
    DateTime today = DateTime.now();
    if (lastLogin!.isBefore(today)) {
      preferences.remove("id");
      preferences.remove("email");
      preferences.remove("token");
    }

    if (token != null) {
      prescriptioncount =
          await apiProvider.getPrescriptionCount(token.toString());
      patientcount = await apiProvider.getPatientCount(token.toString());
    }
    setState(() {});
  }

  getgreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = 'Good Morning';
    }
    if (hour > 11 && hour < 17) {
      greeting = ' Good Afternoon';
    }
    if (hour > 16) {
      greeting = 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      //   splashColor: Colors.red,
      //   onPressed: () {
      //     Navigator.pushReplacementNamed(context, "/patientadd");
      //   },
      // ),
      appBar: AppBar(
        title: const Text("HOME"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "dotplus",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ), // ${patientcount.patientCount.toString()} //${prescriptioncount!.patientCount.toString()}
              Text(
                '$greeting $doctorfirstName $doctorLastName Happy to connect with you again. your service are always valuable for us. So far, you’ve served - ',
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              Text(
                'Patient : ' + patientcount.patientCount.toString(),
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              Text(
                'Prescription :' + prescriptioncount.patientCount.toString(),
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              Text(
                'Thank you for all of your contributions.',
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Button(
                  addData: () {
                    Navigator.pushReplacementNamed(context, "/faq");
                  },
                  icon: Icons.quiz,
                  text: "FAQ")
            ],
          )),
    );
  }
}
