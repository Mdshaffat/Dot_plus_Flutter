import 'package:flutter/material.dart';

class IntegerDropDown extends StatefulWidget {
  List<int> newlist;
  int? targetvalue;
  String title;
  IntegerDropDown(
      {Key? key,
      required this.newlist,
      required this.targetvalue,
      required this.title})
      : super(key: key);

  @override
  State<IntegerDropDown> createState() => _IntegerDropDownState();
}

class _IntegerDropDownState extends State<IntegerDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: DropdownButton<int>(
        hint: Text(widget.title),
        value: widget.targetvalue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (int? newValue) {
          setState(() {
            widget.targetvalue = newValue!;
          });
        },
        items: <int>[...widget.newlist].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
