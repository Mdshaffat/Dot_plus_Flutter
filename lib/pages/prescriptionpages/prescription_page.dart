import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/multiline_text_field.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  String dropdownValue = 'One';
  DateTime? dateOfBirth;
  bool primaryMember = false;

  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';
  @override
  initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      doctorfirstName = preferences.getString("firstName");
      doctorLastName = preferences.getString("lastName");
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != dateOfBirth) {
      setState(() {
        dateOfBirth = pickedDate;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var leftsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          const MultilineTextField(
            controller: null,
            hintText: 'Cc',
            minLines: 6,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Systemic Examination',
            minLines: 5,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'OB-gyn/H',
            minLines: 4,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'History of Past Illness',
            minLines: 3,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Family History',
            minLines: 3,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Allergic History',
            minLines: 2,
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Investigation',
            minLines: 5,
          ),
          dropdown(),
          dropdown()
        ],
      ),
    );
    var rightsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          dropdown(),
          dropdown(),
          dropdown(),
          GestureDetector(
            onTap: () => {},
            child: Container(
              width: 200,
              height: 50,
              // color: Colors.blueAccent,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.add, color: Colors.white),
                  Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Comment',
            minLines: 5,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  dateOfBirth != null ? dateOfBirth.toString() : 'Pick a Date'),
              TextButton(
                onPressed: () => _selectDate(context),
                child: const Text('Date Of Birth'),
              ),
              Checkbox(
                checkColor: Color.fromARGB(255, 36, 71, 226),
                activeColor: Colors.red,
                value: primaryMember,
                onChanged: (bool? value) {
                  setState(() {
                    primaryMember = value!;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
    var _header = SizedBox(
      width: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo/idflogo.jpeg",
            height: 70,
            width: 70,
            alignment: Alignment.center,
          ),
          const SizedBox(
            width: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Health Program"),
              const Text("Integrated Development Foundation"),
              Text("Prescribed By: $doctorfirstName $doctorLastName"),
            ],
          )
        ],
      ),
    );
    var virticalScroolView = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header,
              Container(
                height: 1,
                width: 700,
                color: Colors.grey,
              ),
              Text('Patient ID: '),
              Container(
                height: 1,
                width: 700,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    width: 200,
                    child: leftsideScrollView,
                  ),
                  const Divider(
                    thickness: 4.0,
                    color: Colors.blue,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: 500,
                    child: rightsideScrollView,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Form(key: _formKey, child: virticalScroolView),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> dropdown() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
