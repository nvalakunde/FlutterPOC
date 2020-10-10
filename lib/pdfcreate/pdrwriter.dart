import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/services.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

class PDFPrintUI extends StatefulWidget {
  @override
  _PDFPrintUIState createState() => _PDFPrintUIState();
}

class _PDFPrintUIState extends State<PDFPrintUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello World!'),
          RaisedButton(
            child: Text("Create PDF"),
            onPressed: () {
              _openFileExplorer();
            },
          )
        ],
      ),
    );
  }

  Future<void> _openFileExplorer() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    Future<Directory> downloadsDirectory =
        DownloadsPathProvider.downloadsDirectory;
    Directory _downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    String dir;
    if (Platform.isIOS) {
      dir = (await getApplicationDocumentsDirectory()).absolute.path;
    } else {
      dir = _downloadsDirectory.path;
    }
    final String path = '$dir/example.pdf';
    print(path);
    final File file = File(path);
    List<String> basename = path.split("/");
    int len = basename.length;
    String fileName = basename[len - 2] + "/" + basename[len - 1];
    await file.writeAsBytes(doc.save());
    doc.save();
  }
}
