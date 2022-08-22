import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital_app/Models/physicalStatModel/physical_stat.dart';

class PhysicalSatDetails extends StatelessWidget {
  final PhysicalStat physicalStat;
  const PhysicalSatDetails({Key? key, required this.physicalStat})
      : super(key: key);

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
                            Text(physicalStat.id.toString()),
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
                            Text(physicalStat.heightFeet.toString() +
                                ' feet ' +
                                physicalStat.heightInches.toString() +
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
                            Text(physicalStat.bodyTemparature ?? ' '),
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
                            Text(physicalStat.bloodPressureSystolic ?? " "),
                            Text(physicalStat.bloodPressureDiastolic ?? " "),
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
                            Text(physicalStat.pulseRate.toString()),
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
          ),
        ),
      ),
    );
    ;
  }
}
