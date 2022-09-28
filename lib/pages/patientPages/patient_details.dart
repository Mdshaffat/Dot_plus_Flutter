import 'package:flutter/material.dart';
import 'package:hospital_app/Models/patientOfflineModel.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PatientDetails extends StatelessWidget {
  final PatientOfflineModel patient;
  const PatientDetails({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const SizedBox(
                      height: 30,
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Offline Serial :"),
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
                        padding: const EdgeInsets.all(8.0),
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
                        child: Text("Age (If you input age) :"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Day :" + patient.day.toString()),
                            Text("Month :" + patient.month.toString()),
                            Text("Year :" + patient.year.toString()),
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
                        child: Text("Date Of Birth :"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(patient.doB ?? ''),
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
                            Text(patient.primaryMember == 1 ? "Yes" : "No"),
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
                            Text(patient.membershipRegistrationNumber ?? " "),
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
                            Text(patient.heightFeet.toString() +
                                " feet " +
                                patient.heightInches.toString() +
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
                            Text(patient.weight.toString()),
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
                            Text(patient.bodyTemparature ?? " "),
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
                            Text(patient.appearance ?? " "),
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
                            Text(patient.anemia ?? " "),
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
                            Text(patient.jaundice ?? " "),
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
                            Text(patient.dehydration ?? " "),
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
                            Text(patient.edema ?? " "),
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
                            Text(patient.cyanosis ?? " "),
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
                            Text(patient.rbsFbs ?? " "),
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
                            Text(patient.bloodPressureSystolic ?? " "),
                            Text(patient.bloodPressureDiastolic ?? " "),
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
                            Text(patient.pulseRate.toString()),
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
                            Text(patient.spO2.toString()),
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
      ),
    );
  }
}
