import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hospital_app/widgets/RoundedButton.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PatientCard extends StatelessWidget {
  final String data;
  const PatientCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 500,
            height: 900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardDesign(),
                const SizedBox(
                  height: 30,
                ),
                _cardDesignBack(),
                Button(
                    addData: () {
                      _printCard();
                    },
                    icon: Icons.print,
                    text: " ")
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cardDesign() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            height: 216,
            width: 336,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo/halimalogo.jpeg",
                      height: 70,
                      width: 70,
                      alignment: Alignment.center,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Halima Hospital",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "In Cooperation with Integrated Development Foundation",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Address: Mohora, Chittagong, Bangladesh",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Patient Card",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 140,
                    ),
                    QrImage(
                      data: data,
                      version: QrVersions.auto,
                      size: 100,
                      gapless: false,
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
          )
        ],
      ),
    );
  }

  _cardDesignBack() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            height: 216,
            width: 336,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 216,
              width: 336,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "www.halimahospital.org | info@halimahospital.org",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _printCard() async {
    try {
      final doc = pw.Document();
      final image =
          await imageFromAssetBundle("assets/images/logo/halimalogo.jpeg");

      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              frontPage(image),
////

              pw.SizedBox(height: 10),

              /////
              backPage()
            ]);
          })); // Page
      await Printing.sharePdf(
          bytes: await doc.save(), filename: 'my-document.pdf');
      return doc.save();
    } catch (ex) {
      print(ex.toString());
    }
  }

  pw.Padding frontPage(pw.ImageProvider image) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Stack(
        children: [
          pw.Container(
            height: 216,
            width: 336,
            decoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
              color: PdfColor.fromHex("#F0ECED"),
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image,
                        height: 70,
                        width: 70,
                        alignment: pw.Alignment.center,
                      ),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("Halima Hospital",
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Text(
                              "In Cooperation with Integrated Development Foundation",
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Text("Address: Mohora, Chittagong, Bangladesh",
                              style: pw.TextStyle(fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                  pw.Row(children: [
                    pw.SizedBox(
                      width: 150,
                    ),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("Patient Card",
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Center(
                            child: pw.BarcodeWidget(
                                data: data,
                                barcode: pw.Barcode.qrCode(),
                                width: 100,
                                height: 100),
                          )
                        ])
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Padding backPage() {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Stack(
        children: [
          pw.Container(
            height: 216,
            width: 336,
            decoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
              color: PdfColor.fromHex("#F0ECED"),
            ),
            child: pw.Center(
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                    "www.halimahospital.org | info@halimahospital.org",
                    style: pw.TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.BarcodeWidget(
                data: "demo",
                barcode: pw.Barcode.qrCode(),
                width: 100,
                height: 50),
          );
        },
      ),
    );
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'my-document.pdf');
    return pdf.save();
  }
}
