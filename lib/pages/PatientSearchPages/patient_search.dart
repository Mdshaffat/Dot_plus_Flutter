import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/providers/apiProvider/api_provider.dart';
import 'package:hospital_app/utils/app_drawer.dart';

import '../../Models/PatientSearch/search_patient.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({Key? key}) : super(key: key);

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  final TextEditingController _patientController = TextEditingController();

  var apiProvider = ApiProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _patientController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Search Patient',
                style: GoogleFonts.alegreya(
                  fontSize: 40,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: TypeAheadField<SearchPatient>(
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _patientController,
                      autofocus: true,
                      style: DefaultTextStyle.of(context).style.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontSize: 16),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Patient Mobile Number",
                          hintStyle: null)),
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty || pattern.length < 10) {
                      return [];
                    }
                    var ex = await apiProvider.getSearchedPatient(pattern);
                    return ex;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(suggestion.id.toString()),
                          const Text('|'),
                          Text((suggestion.firstName != null)
                              ? suggestion.firstName!
                              : ''),
                          Text((suggestion.lastName != null)
                              ? suggestion.lastName!
                              : ''),
                          const Text('|'),
                          Text((suggestion.mobileNumber != null)
                              ? suggestion.mobileNumber!
                              : ''),
                        ],
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _patientController.text =
                          suggestion.firstName! + '' + suggestion.lastName!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
