import 'package:flutter/material.dart';

class TableViewUI extends StatefulWidget {
  @override
  _TableViewUIState createState() => _TableViewUIState();
}

class _TableViewUIState extends State<TableViewUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border: TableBorder.all(
              color: Colors.black26, width: 1, style: BorderStyle.none),
          children: [
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('Sr No'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Name'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('Points'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('NRR'),
                ),
              ),
            ]),
            
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('1'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('MI'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('4'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('+2.2003'),
                ),
              ),
            ]),
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text('2'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('CSK'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('3'),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text('+1.2453'),
                ),
              ),
            ]),
            
          ],
        ),
      ),
    );
  }
}
