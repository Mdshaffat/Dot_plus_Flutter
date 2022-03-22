import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Container(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.zero),
            ListTile(
              autofocus: true,
              title: const Text(
                "Sync Data",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              onTap: () => {
                Navigator.pushReplacementNamed(context, "/datasync"),
              },
              hoverColor: Colors.red,
            ),
            ListTile(
              autofocus: true,
              title: const Text(
                "Patient",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () => {
                Navigator.pushReplacementNamed(context, "/patientlist"),
              },
              hoverColor: Colors.red,
            ),
            ListTile(
              autofocus: true,
              title: const Text(
                "Logout",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () async => {
                //
                logout(),
                Navigator.pushReplacementNamed(context, "/login"),
              },
              hoverColor: Colors.red,
            )
          ],
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
