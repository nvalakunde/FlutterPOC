import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';

class CustomPdfViewer extends StatefulWidget {
  String apiData;
  CustomPdfViewer(String apData) {
    this.apiData = apData;
  }
  @override
  _CustomPdfViewerState createState() => new _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer>
    with WidgetsBindingObserver {
  String apiData;
  @override
  void initState() {
    super.initState();
    print("Custom PDF");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return

        PDFViewerScaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        backgroundColor: themeColorBlue,
        title: Text("Receipt",
            style: txtStyle(18, whiteColor, fontWeight: FontWeight.bold)),
        actions: <Widget>[
        ],
      ),
      path: widget.apiData,
    );
    // ));
  }
}
