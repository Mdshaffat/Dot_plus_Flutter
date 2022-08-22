import 'dart:ui';

import 'package:flutter/material.dart';

class ReadOnlyTextField extends StatelessWidget {
  final int minLines;
  final int? maxLines;
  // final TextEditingController? controller;
  final String? initialValue;
  final String hintText;
  final bool isKeyboardNumber;

  const ReadOnlyTextField(
      {Key? key,
      required this.minLines,
      this.maxLines,
      // required this.controller,
      this.initialValue,
      required this.hintText,
      this.isKeyboardNumber = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        readOnly: true,
        //controller: controller,
        initialValue: initialValue,
        keyboardType:
            isKeyboardNumber ? TextInputType.number : TextInputType.multiline,
        minLines: minLines,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14.0),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black, width: 3.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
    );
  }
}
