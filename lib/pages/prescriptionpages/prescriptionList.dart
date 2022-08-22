import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_app/API/api.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/diagnosis.dart';
import 'package:hospital_app/Models/diseaseAndMedicine/medicine_for_prescription.dart';
import 'package:hospital_app/Models/patient.dart';
import 'package:hospital_app/Models/prescription_model/prescription_dto.dart';
import 'package:hospital_app/Models/prescription_model/prescription_with_medicine_and_diagnosis.dart';
import 'package:hospital_app/pages/prescriptionpages/add_prescription.dart';
import 'package:hospital_app/pages/prescriptionpages/prescription_details.dart';
import 'package:hospital_app/pages/prescriptionpages/prescription_update.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/response.dart';
import '../../providers/db_provider.dart';
import '../../utils/app_drawer.dart';

class PrescriptionList extends StatefulWidget {
  const PrescriptionList({Key? key}) : super(key: key);

  @override
  State<PrescriptionList> createState() => _PrescriptionListState();
}

class _PrescriptionListState extends State<PrescriptionList> {
  Paginations? paginations;
  List<PrescriptionDto> prescriptions = [];
  List<String> str = [];
  DBProvider? dbProvider;
  HasNetWork hasNetWork = HasNetWork();
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  void initState() {
    super.initState();
    dbProvider = DBProvider.db;
    loadPrescription();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        splashColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const AddPrescription())));
        },
      ),
      appBar: AppBar(
        title: const Text("Prescription Offline List"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : DataTable(
                    columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Serial No.',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Patient Id',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Upload',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    rows: prescriptions.isNotEmpty
                        ? prescriptions
                            .map(
                              (e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(e.id.toString())),
                                  DataCell(Text(e.patientId.toString())),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.info,
                                          ),
                                          iconSize: 25,
                                          color: Colors.blue,
                                          splashColor: Colors.purple,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        PrescriptionDetails(
                                                            prescription: e))));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                          ),
                                          iconSize: 25,
                                          color: Colors.blue,
                                          splashColor: Colors.purple,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        PrescriptionUpdatePage(
                                                            prescription: e))));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.send,
                                          ),
                                          iconSize: 25,
                                          color: Colors.blue,
                                          splashColor: Colors.purple,
                                          onPressed: () {
                                            _showMyDialog(e.id!);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList()
                        : <DataRow>[
                            const DataRow(
                              cells: <DataCell>[
                                DataCell(Text('0')),
                                DataCell(Text('0')),
                                DataCell(Text('************')),
                              ],
                            ),
                          ])),
      ),
    );
  }

  loadPrescription() async {
    isLoading = true;

    prescriptions = [];
    // final response = await http.get(Uri.parse(DIVISIONURI));

    List<PrescriptionDto> totalprescription =
        await dbProvider?.getAllPrescription();
    if (totalprescription.isNotEmpty) {
      setState(() {
        prescriptions = totalprescription;
        isLoading = false;
      });
    } else {
      setState(() {
        prescriptions = [];
        isLoading = false;
      });
    }
  }

  deletePatient(int id) async {
    var deletePatient = await dbProvider?.deletePrescription(id);
    loadPrescription();
    return deletePatient;
  }

  sendPrescriptionToOnline(int id) async {
    bool isOnline = await hasNetWork.hasNetwork();
    if (isOnline) {
      setState(() {
        isLoading = true;
      });
      try {
        List<PrescriptionDto> totalPrescription =
            await dbProvider?.getPrescription(id);
        if (totalPrescription.isNotEmpty) {
          PrescriptionDto prescription = totalPrescription[0];
          List<MedicineForPrescription> totalMedicinePrescription =
              await dbProvider?.getMedicineForPrescriptionByPrescriptionId(
                  prescription.id!);
          List<Diagnosis> diagnosisForPrescription =
              await dbProvider?.getDiagnosisForPrescription(prescription.id!);

          PrescriptionWithMedicineAndDiagnosis
              prescriptionWithMedicineAndDiagnosis =
              PrescriptionWithMedicineAndDiagnosis(
                  prescriptionDto: prescription,
                  diagnosisList: diagnosisForPrescription,
                  medicineForPrescription: totalMedicinePrescription);

          var data = prescriptionWithMedicineAndDiagnosis.toJson();
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final String? token = preferences.getString("token");
          if (token == null) {
            Navigator.pushReplacementNamed(context, "/login");
            scaffoldMessenger
                .showSnackBar(const SnackBar(content: Text("Please Login")));
          } else {
            final response = await http.post(Uri.parse(PRESCRIPTIONADD),
                headers: {
                  "Accept": "application/json",
                  "content-type": "application/json",
                  "Authorization": 'Bearer $token',
                },
                body: jsonEncode(data),
                encoding: Encoding.getByName("utf-8"));

            if (response.statusCode > 400) {
              Map<String, dynamic> resposne = jsonDecode(response.body);
              var responseData = ResponseData.fromJson(resposne);
              if (responseData.message == "patientnotfound") {
                scaffoldMessenger.showSnackBar(const SnackBar(
                    content: Text("The Patient Id You Entered Is Not Found!")));
              } else {
                scaffoldMessenger.showSnackBar(SnackBar(
                    content: Text("${response.statusCode} + Error To Send!")));
              }
            } else {
              Map<String, dynamic> resposne = jsonDecode(response.body);
              var responseData = ResponseData.fromJson(resposne);
              if (responseData.message == "success") {
                await dbProvider?.deletePrescription(prescription.id!);
                await dbProvider?.deleteMedicineForPrescriptionByPrescriptionId(
                    prescription.id!);
                await dbProvider
                    ?.deleteDiagnosisByPrescriptionId(prescription.id!);
                _showDialogWithPrescriptionId(responseData.data!);
                await loadPrescription();

                scaffoldMessenger
                    .showSnackBar(const SnackBar(content: Text("Success")));
              }
            }
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } else {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text(" Please check Your Connection !")));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Online'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Send To Online'),
                Text('Are you sure send data to online ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                sendPrescriptionToOnline(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialogWithPrescriptionId(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prescription Id :' + id),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
