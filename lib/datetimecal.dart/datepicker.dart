import 'package:flutter/material.dart';

class DatePickerUI extends StatefulWidget {
  @override
  _DatePickerUIState createState() => _DatePickerUIState();
}

class _DatePickerUIState extends State<DatePickerUI> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2013, 8),
        lastDate: DateTime(2020,11));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<DateTime> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2020),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      return picked;
    }
  }

   Future<TimeOfDay> _showTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      return picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date Picker Example"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text("${selectedTime}"),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _showTimePicker(),
              child: Text('Select time'),
            ),
          ],
        ),
      ),
    );
  }
}
