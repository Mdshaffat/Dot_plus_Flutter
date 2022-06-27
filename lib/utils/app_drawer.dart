import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RouterClass {
  String title;
  String routeName;
  RouterClass(this.title, this.routeName);
}

class AppDrawer extends StatelessWidget {
  List<RouterClass> routers = [
    RouterClass('SyncData', '/datasync'),
    RouterClass('Patient in Offline', '/patientofflinelist'),
    RouterClass('Telemedicine', '/users'),
    RouterClass('Calling Information', '/callinfo'),
    RouterClass('SyncData', '/datasync'),
    RouterClass('SyncData', '/datasync'),
  ];
  AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100))),
        backgroundColor: Colors.blue,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue,
          ),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Center(
                  child: Text(
                    'dotplus',
                    style:
                        GoogleFonts.pottaOne(fontSize: 50, color: Colors.white),
                  ),
                ),
              ),
              Text(
                'Offline Section',
                style: GoogleFonts.ibmPlexMono(
                    fontSize: 25, color: Colors.black54),
              ),
              RouteList(
                  title: "Patient",
                  route: () {
                    Navigator.pushReplacementNamed(
                        context, "/patientofflinelist");
                  }),
              RouteList(
                  title: 'PhysicalStat',
                  route: () {
                    Navigator.pushReplacementNamed(context, "/physicalstat");
                  }),
              RouteList(
                  title: 'Prescription',
                  route: () {
                    Navigator.pushReplacementNamed(context, "/prescription");
                  }),
              RouteList(
                  title: 'Telemedicine',
                  route: () {
                    Navigator.pushReplacementNamed(context, "/users");
                  }),
              RouteList(
                  title: 'Calling Information',
                  route: () {
                    Navigator.pushReplacementNamed(context, "/callinfo");
                  }),
              RouteList(
                  title: "FAQ",
                  route: () {
                    Navigator.pushReplacementNamed(context, "/faq");
                  }),
              Text(
                'Online Section',
                style: GoogleFonts.ibmPlexMono(
                    fontSize: 25, color: Colors.black54),
              ),
              RouteList(
                  title: 'Sync Data',
                  route: () {
                    Navigator.pushReplacementNamed(context, "/datasync");
                  }),
              RouteList(
                  title: "Patient",
                  route: () {
                    Navigator.pushReplacementNamed(context, "/patientlist");
                  }),
              RouteList(
                  title: "Prescription",
                  route: () {
                    Navigator.pushReplacementNamed(
                        context, "/prescriptiononline");
                  }),
              RouteList(
                  title: "Search Existing Patient",
                  route: () {
                    Navigator.pushReplacementNamed(context, "/patientsearch");
                  }),
              RouteList(
                  title: 'Logout',
                  route: () {
                    logout();
                    Navigator.pushReplacementNamed(context, "/login");
                  }),
            ],
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    preferences.remove("id");
    preferences.remove("email");
    preferences.remove("token");
  }
}

class RouteList extends StatelessWidget {
  String title;
  Function route;
  RouteList({
    required this.title,
    required this.route,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          height: 2,
        ),
        ListTile(
          autofocus: true,
          title: Text(title,
              style: GoogleFonts.righteous(color: Colors.white, fontSize: 18)),
          onTap: () {
            route();
          },
          hoverColor: Colors.red,
        ),
      ],
    );
  }
}

// () => {
//         Navigator.pushReplacementNamed(context, "/datasync"),
//       },
