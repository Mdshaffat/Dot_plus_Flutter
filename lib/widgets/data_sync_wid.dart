import 'package:flutter/material.dart';

class DataSyncWidget extends StatelessWidget {
  final Function loadData;
  final String count;
  final String title;
  const DataSyncWidget(
      {Key? key,
      required this.loadData,
      required this.count,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          // focusColor: Colors.black,
          // highlightColor: Colors.black,
          // hoverColor: Colors.black,
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            loadData();
          },
          child: SizedBox(
            width: 100,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  count,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
