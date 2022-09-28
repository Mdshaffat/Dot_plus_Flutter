import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../API/api.dart';
import '../../Models/patient/get_patient.dart';
import '../../widgets/RoundedButton.dart';

class PatientOnlineDetails extends StatefulWidget {
  const PatientOnlineDetails({Key? key}) : super(key: key);

  @override
  State<PatientOnlineDetails> createState() => _PatientOnlineDetailsState();
}

class _PatientOnlineDetailsState extends State<PatientOnlineDetails> {
  int? patientId;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GetPatientData patient = GetPatientData(
      id: 0,
      hospitalId: 0,
      hospitalName: 'none',
      physicalStat: [PhysicalStat(id: 0, hospitalId: 0, patientId: 0)]);
  PhysicalStat physicalStat = PhysicalStat(id: 0, hospitalId: 0, patientId: 0);
  @override
  void initState() {
    super.initState();
  }

  getData(int? id) async {
    setState(() {
      isLoading = true;
    });
    // if id == null
    if (id == null || id == 0) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    // getting data
    try {
      Response response = await Dio().get(PATIENTURI + "/patientWithVital/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        patient = GetPatientData.fromJson(response.data);
        physicalStat = patient.physicalStat[0];
      }
    } catch (data) {
      setState(() {
        isLoading = false;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Details"),
      ),
      key: _scaffoldKey,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 200,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14.0),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 3.0),
                                  ),
                                  hintText: 'Patient ID',
                                  hintStyle: TextStyle(
                                      color: Colors.black54, fontSize: 15),
                                ),
                                onChanged: ((value) {
                                  patientId = int.parse(value);
                                }),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Button(
                                icon: Icons.search,
                                text: 'Search',
                                addData: () {
                                  getData(patientId);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // patient Information
                    // QR Code\

                    const SizedBox(
                      height: 40,
                    ),
                    if (patientId != null)
                      Column(
                        children: [
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(200),
                              1: FixedColumnWidth(300),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Id :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.id.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Hospital Id :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.hospitalId.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Branch Id :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.branchId.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Name :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.firstName ?? ''),
                                          Text(patient.lastName ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Mobile Number :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.mobileNumber ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Gender :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.gender ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Matiral Status :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.maritalStatus ?? ''),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Primary Member :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.primaryMember == 1
                                              ? "Yes"
                                              : "No"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Mem. Reg. No :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient
                                                  .membershipRegistrationNumber ??
                                              " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Address :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.address ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("NID :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.nid ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Blood Group :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.bloodGroup ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Note :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(patient.note ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Height :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.heightFeet
                                                  .toString() +
                                              " feet " +
                                              physicalStat.heightInches
                                                  .toString() +
                                              " inch "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Weight :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.weight.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Body Temp :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.bodyTemparature ??
                                              " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Appearance :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.appearance ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Anemia :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.anemia ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Jaundice :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.jaundice ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Dehydration :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.dehydration ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Edema :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.edema ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Cyanosis :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.cyanosis ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("RBS/FBS :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.rbsFbs ?? " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Blood Pressure :"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat
                                                  .bloodPressureSystolic ??
                                              " "),
                                          Text(physicalStat
                                                  .bloodPressureDiastolic ??
                                              " "),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Pulse Rate:"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.pulseRate
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("SPO2:"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(physicalStat.spO2.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          QrImage(
                            data:
                                '{"id": ${patient.id}, "firstname": "${patient.firstName}" ,"lastname": "${patient.lastName}" , "mobileNumber": "${patient.mobileNumber ?? "not found"}" }',
                            version: QrVersions.auto,
                            size: 320,
                            gapless: false,
                            embeddedImage:
                                const AssetImage('assets/images/logo.png'),
                            errorStateBuilder: (cxt, err) {
                              return const Center(
                                child: Text(
                                  "Uh oh! Something went wrong...",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
