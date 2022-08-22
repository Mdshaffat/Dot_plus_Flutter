import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/pages/home.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../API/api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/images/background.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                    )),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 45),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                              onSaved: (val) {
                                email = val!;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              obscureText: true,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              onSaved: (val) {
                                email = val!;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      scaffoldMessenger.showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Please Fill all fileds")));
                                      return;
                                    }
                                    login(_emailController.text,
                                        _passwordController.text);
                                    //Navigator.pushReplacementNamed(context, "/home");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "SUBMIT",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              letterSpacing: 1)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: (isLoading)
                                      ? const Center(
                                          child: SizedBox(
                                              height: 26,
                                              width: 26,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.green,
                                              )))
                                      : Container(),
                                  right: 30,
                                  bottom: 0,
                                  top: 0,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  login(email, password) async {
    setState(() {
      isLoading = true;
    });
    try {
      var data = jsonEncode({'email': email, 'password': password});
      final response = await http.post(Uri.parse(LOGIN),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne.isNotEmpty) {
          savePref(resposne['userId'], resposne['email'], resposne['token'],
              resposne['firstName'], resposne['lastName']);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => const Home())));
        } else {
          scaffoldMessenger.showSnackBar(const SnackBar(
              content: Text(
                  "Something wrong!! please contact with responsible person.")));
        }
      }
      if (response.statusCode > 400) {
        Map<String, dynamic> resposne = jsonDecode(response.body);
        if (resposne['title'] == 'Unauthorized') {
          scaffoldMessenger.showSnackBar(
              const SnackBar(content: Text("Email or Password is incorrect!")));
        }
      }
    } catch (value) {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Error to login!")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  savePref(
    String id,
    String email,
    String token,
    String firstName,
    String lastName,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("email", email);
    preferences.setString("token", token);
    preferences.setString("firstName", firstName);
    preferences.setString("lastName", lastName);
    preferences.setString("lastLoginDate", DateTime.now().toIso8601String());
  }
}
