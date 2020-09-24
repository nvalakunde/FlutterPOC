import 'package:flutter/material.dart';

class CheckBoxUI extends StatefulWidget {
  @override
  CheckBoxUIState createState() => new CheckBoxUIState();
}

class CheckBoxUIState extends State<CheckBoxUI> {
  Map<String, bool> values = {
    'Select 1': true,
    'Select 2': false,
    'Select 3': false,
    'Select 4': false,
    'Select 5': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: values[key],
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
      ),
    );
  }
}