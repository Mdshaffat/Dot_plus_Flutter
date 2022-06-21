import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/db_provider.dart';
import '../../widgets/multiline_text_field.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key}) : super(key: key);

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  String? medicineDose;
  String? medicinetakingtime;
  DateTime? dateOfBirth;
  bool primaryMember = false;

  late String? doctorfirstName = ' ';
  late String? doctorLastName = '';
  String sometext = '';

  DBProvider? dbProvider;
  @override
  initState() {
    super.initState();
    dbProvider = DBProvider.db;
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
          // dropdown(),
          // dropdown()
        ],
      ),
    );
    var rightsideScrollView = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Text('Search Medicine'),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TypeAheadField<Medicine>(
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 16),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        if (pattern.isEmpty) {
                          return [];
                        }
                        var ex = await dbProvider!.searchMedicine(pattern);
                        return ex;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.brandName),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          sometext = suggestion.brandName;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Dose'),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton<String>(
                      value: medicineDose,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          medicineDose = newValue!;
                        });
                      },
                      items: <String>[
                        '1+1+1',
                        '1+0+1',
                        '0+0+1',
                        '1+0+0',
                        '0+1+0',
                        '0+1+1',
                        '1+1+1+1',
                        '1+1+0',
                        '2+2+2+2',
                        '2+2+2',
                        '1/2+0+0',
                        '1/2+0+1/2',
                        '1/2+1/2+1/2'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Time'),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: DropdownButton<String>(
                      value: medicinetakingtime,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          medicinetakingtime = newValue!;
                        });
                      },
                      items: <String>['Before Meal', 'After Meal']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 300,
                child: const MultilineTextField(
                  controller: null,
                  hintText: 'Comment',
                  minLines: 1,
                ),
              ),
              AddButton(),
            ],
          ),
          const MultilineTextField(
            controller: null,
            hintText: 'Comment',
            minLines: 5,
          ),
          Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Text(dateOfBirth != null
                      ? dateOfBirth.toString()
                      : 'Pick a Date'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Next Visit'),
                  )
                ],
              ),
              Row(
                children: [
                  Text('Telemedicine'),
                  Checkbox(
                    checkColor: Color.fromARGB(255, 36, 71, 226),
                    activeColor: Colors.red,
                    value: primaryMember,
                    onChanged: (bool? value) {
                      setState(() {
                        primaryMember = value!;
                      });
                    },
                  )
                ],
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
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 150,
        height: 40,
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
    );
  }
}
