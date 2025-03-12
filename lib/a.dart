import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> names = List.generate(
    200, (index) => "${String.fromCharCode(65 + Random().nextInt(26))}Name$index",
  );
  String? selectedLetter;

  @override
  Widget build(BuildContext context) {
    List<String> filteredNames = selectedLetter == null
        ? names
        : names.where((name) => name.startsWith(selectedLetter!)).toList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Name Filter"),
          actions: [
            DropdownButton<String>(
              hint: Text("Filter"),
              value: selectedLetter,
              items: [null, ...List.generate(26, (index) => String.fromCharCode(65 + index))]
                  .map((letter) => DropdownMenuItem<String>(
                value: letter,
                child: Text(letter ?? "All"),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedLetter = value;
                });
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: filteredNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredNames[index]),
            );
          },
        ),
      ),
    );
  }
}
