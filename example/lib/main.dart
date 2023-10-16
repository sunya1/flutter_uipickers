import 'package:flutter/material.dart';
import 'package:uipickers/pickers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

DateTime selectedDate = DateTime.now();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Center(
              child: Column(
                children: [
                  HCBAdaptiveDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2010, 1, 1),
                    lastDate: DateTime.now(),
                    cornerRadius: 16,
                    onChanged: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                  Text(
                    selectedDate.toString(),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  )
                ],
              ),
            )));
  }

  int daysBetween(DateTime from, DateTime to) {
    var fromD = DateTime(from.year, from.month, from.day);
    var toD = DateTime(to.year, to.month, to.day);
    return (toD.difference(fromD).inHours / 24).round();
  }
}
