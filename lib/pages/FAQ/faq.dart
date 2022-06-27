import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_app/utils/app_drawer.dart';

class FAQQuestionAndText {
  String? question;
  String? answere;
  FAQQuestionAndText(this.question, this.answere);
}

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  final List<FAQQuestionAndText> faqList = [
    FAQQuestionAndText('What should I do first after Install dotplus ?',
        'First thing first, after Install dotplus sign in with your email and password , then click the menu Icon and go to "Sync Data" page and click All of the given button one by one that will download all of the required data. After Completing this task you are ready to work!!! Note: this process required only for the first time login.'),
    FAQQuestionAndText('How can I serve New Patient?',
        '1. Go to patient Offline section > click add(+) Icon > Fill up new patient Form Carefully > Save It. 2. If you need to generate prescription for this patient => Go to Patient List in Offline section > Send Patient Data to Online > Go to "Patient" Online section > collect Patient Id > then generate Prescription.'),
    FAQQuestionAndText('How can I serve followup Patient?',
        'Add Physical stat > Generate Prescription'),
    FAQQuestionAndText('How to Generate a Prescription ? ',
        'Go to Prescription(Offline Section) > Click Add(+) Button > Type the Patient Id > Select Hospital > Next Page > Then Fillup the prescription Form And Save It.Note: Be carefull when you type patientId. and Re-Check Before you Save the prescription.'),
    FAQQuestionAndText('How to add Physical Stat ?',
        'Go to physical stat Offline section > click + button > fill up the physical stat form > save it'),
    FAQQuestionAndText('Do I have to Add Physical stat for New Patient?',
        'No!!! you do not need to add physical stat for the new patient. physical stat only need for the followup patient'),
    FAQQuestionAndText(
        'How can I get Patient Id If some patient forget there ID?',
        'dotplus app also provide this facility to find followup patientID If your device has data connection. Just go to Search Patient section and search patient by their mobile number or name'),
    FAQQuestionAndText(
        'Do I have to follow any rules for uploding data from offline to online?',
        'Of course! First you need to upload all of the patient data then Upload physical stat Data then Prescription Data'),
    FAQQuestionAndText('Technical Support',
        'For technical support: dotplusfeedback@gmail.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: ((context, index) {
            return FaqList(
              question: faqList[index].question,
              answere: faqList[index].answere,
            );
          })),
    );
  }
}

class FaqList extends StatefulWidget {
  final String? question;
  final String? answere;
  const FaqList({Key? key, this.question, this.answere}) : super(key: key);

  @override
  State<FaqList> createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.question!,
              style: GoogleFonts.alegreyaSc(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Text(
                  widget.answere!,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                  ),
                )),
        ],
      ),
    );
  }
}
