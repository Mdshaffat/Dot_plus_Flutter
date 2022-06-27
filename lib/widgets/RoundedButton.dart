import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Function addData;
  IconData icon;
  String text;
  Button({
    required this.addData,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => addData()),
      child: Container(
        width: 150,
        height: 40,
        // color: Colors.blueAccent,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.white),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
