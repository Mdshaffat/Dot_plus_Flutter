import 'package:flutter/material.dart';

class StringDropDown extends StatefulWidget {
  List<String> newlist;
  String? targetvalue;
  String title;
  StringDropDown(
      {Key? key,
      required this.newlist,
      required this.targetvalue,
      required this.title})
      : super(key: key);

  @override
  State<StringDropDown> createState() => _StringDropDownState();
}

class _StringDropDownState extends State<StringDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownButton<String>(
        hint: Text(widget.title),
        value: widget.targetvalue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            widget.targetvalue = newValue!;
          });
        },
        items: <String>[...widget.newlist]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
