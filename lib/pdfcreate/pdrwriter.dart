import 'package:flutter/material.dart';
import 'package:flutter_poc/pdfcreate/pdfreport.dart';

class PDFCreator extends StatefulWidget {
  @override
  _PDFCreatorState createState() => _PDFCreatorState();
}

class _PDFCreatorState extends State<PDFCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create PDF File"),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text("PDF Demo"),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Create Single Page PDF and Display File',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blue,
                onPressed: () {
                  reportViewSinglePage(context);
                },
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Create Multiple Page PDF and Display File',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blue,
                onPressed: () {
                  reportViewMultiplePage(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
