import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';

class FileAttachUI extends StatefulWidget {
  @override
  _FileAttachUIState createState() => _FileAttachUIState();
}

class _FileAttachUIState extends State<FileAttachUI> {
  String _path;
  String _fileName;
  String _extension;
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Example'),
      ),
      body: Column(
        children: [
          askQuestion(context),
        ],
      ),
    );
  }

  Widget askQuestion(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                      left: setHeight(10), bottom: setHeight(10)),
                  child: TextField(
                    minLines: 1,
                    maxLines: 6,
                    style: txtStyle(12, Colors.black),
                    controller: description,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Leave a comment...',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () {
                            _openFileExplorer();
                          },
                        )),
                  )),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: setWidth(60), top: setHeight(10)),
          child: _path != null
              ? Text(
                  _fileName.length > 38
                      ? _fileName.substring(0, 38) + "..."
                      : "" + _fileName,
                  style: txtStyle(12, Colors.black54),
                )
              : Container(),
        ),
      ],
    );
  }

  void _openFileExplorer() async {
    try {
      FilePickerResult result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path);
        _path = file.path;
      }

      if (_path != null) {
        setState(() {
          _fileName = _path.split('/').last;
          _extension = _path.split('.').last;
        });

        if (_extension != "xls" &&
            _extension != "xlsx" &&
            _extension != "docx" &&
            _extension != "doc" &&
            _extension != "txt" &&
            _extension != "odt" &&
            _extension != "jpg" &&
            _extension != "jpeg" &&
            _extension != "png" &&
            _extension != "gif" &&
            _extension != "pdf") {
          setState(() {
            print("_extension   " + _extension);
            _path = null;
            _fileName = "";
            toastFunstion(context,
                'Allowed _extension are [xls,xlsx,docx,doc,txt,odt,jpg,jpeg,png,gif,pdf]');
          });
        } else {
          _fileName = _path.split('/').last;
        }
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }
}
