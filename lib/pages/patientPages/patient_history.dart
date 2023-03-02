import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../API/api.dart';
import '../../Models/QRModel/patient_qr_info.dart';
import '../../Models/patient/get_patient_history.dart';
import 'PatientEditPhysicalStatAndPrescriptionAdd/add_physical_stat.dart';
import 'PatientEditPhysicalStatAndPrescriptionAdd/patient_online_edit.dart';

class PatientHistory extends StatefulWidget {
  PatientQRInfo patientQRInfo;
  PatientHistory({Key? key, required this.patientQRInfo}) : super(key: key);

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  bool isLoading = false;
  PatientHistoryModel? patientHistoryModel;
  onPatientHistoryLoad(int? id) async {
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
      Response response = await Dio().get("$PATIENTHISTORYURI/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        patientHistoryModel = PatientHistoryModel.fromJson(response.data);
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
  void initState() {
    super.initState();
    onPatientHistoryLoad(widget.patientQRInfo.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PatientOnlineEditFromQRDetails(
                              patientID: widget.patientQRInfo.id.toString(),
                            ))));
              },
              icon: const Icon(Icons.edit),
              tooltip: 'Edit Patient Info',
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PhysicalStatAddFromQRDetails(
                              patientid: widget.patientQRInfo.id,
                            ))));
              },
              icon: const Icon(Icons.add),
              tooltip: 'Add Physical Stat',
            ),
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.family_restroom)),
                  Tab(icon: Icon(Icons.settings_accessibility)),
                  Tab(icon: Icon(Icons.medication)),
                ],
              ),
              //title: const Text('Tabs Demo'),
            ),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    children: [
                      // ************PATIENT DETAILS****************** //
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Table(
                                      border: TableBorder.all(),
                                      columnWidths: const <int,
                                          TableColumnWidth>{
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                        .patient.id
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
                                                child: Text("Hospital Id :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                        .patient.hospitalId
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
                                                child: Text("Branch Id :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                        .patient.branchId
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
                                                child: Text("Name :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient
                                                            .firstName ??
                                                        ''),
                                                    Text(patientHistoryModel!
                                                            .patient.lastName ??
                                                        ''),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient
                                                            .mobileNumber ??
                                                        ''),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient.gender ??
                                                        ''),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient
                                                            .maritalStatus ??
                                                        ''),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                                .patient
                                                                .primaryMember ==
                                                            1
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient.address ??
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
                                                child: Text("NID :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient.nid ??
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
                                                child: Text("Blood Group :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient
                                                            .bloodGroup ??
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
                                                child: Text("Note :"),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(patientHistoryModel!
                                                            .patient.note ??
                                                        " "),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // *********** patientHistoryModel!.patient Physical Stat *********** //

                      ListView.builder(
                        itemCount: patientHistoryModel!.physicalState!.length,
                        itemBuilder: ((context, i) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Table(
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
                                            child: Text("Physical stat ID :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                    .physicalState![i].id
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .heightFeet
                                                        .toString() +
                                                    ' feet ' +
                                                    patientHistoryModel!
                                                        .physicalState![i]
                                                        .heightInches
                                                        .toString() +
                                                    ' inch '),
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
                                                Text(patientHistoryModel!
                                                    .physicalState![i].weight
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
                                            child: Text("Body Tempareture :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .bodyTemparature ??
                                                    ' '),
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .appearance ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .anemia ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .jaundice ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .dehydration ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .edema ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .cyanosis ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .rbsFbs ??
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
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
                                                        .bloodPressureSystolic ??
                                                    " "),
                                                Text(patientHistoryModel!
                                                        .physicalState![i]
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
                                                Text(patientHistoryModel!
                                                    .physicalState![i].pulseRate
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
                                                Text(patientHistoryModel!
                                                    .physicalState![i].spO2
                                                    .toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      // *********** PRESCRIPTION **************** //
                      ListView.builder(
                        itemCount: patientHistoryModel!.prescription!.length,
                        itemBuilder: ((context, i) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Table(
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
                                            child: Text("Prescription ID :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                    .prescription![i].id
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
                                            child: Text("Hospital Name :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                    .prescription![i]
                                                    .hospitalName
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
                                            child: Text("Cc :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                        .prescription![i]
                                                        .doctorsObservation ??
                                                    ' '),
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
                                            child: Text("OB-gyn/H :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                        .prescription![i].oh ??
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
                                            child: Text(
                                                "History of Past Illness :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                        .prescription![i]
                                                        .historyOfPastIllness ??
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
                                            child: Text("Allergic History :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(patientHistoryModel!
                                                        .prescription![i]
                                                        .allergicHistory ??
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
                                          height: 300,
                                          width: 100,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Advice Medication :"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 300,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              itemCount: patientHistoryModel!
                                                  .prescription![i]
                                                  .medicineForPrescription!
                                                  .length,
                                              itemBuilder: ((context, j) {
                                                return Text(patientHistoryModel!
                                                        .prescription![i]
                                                        .medicineForPrescription![
                                                            j]
                                                        .brandName
                                                        .toString() +
                                                    ",");
                                              }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
