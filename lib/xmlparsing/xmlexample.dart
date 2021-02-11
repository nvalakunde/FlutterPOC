import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:xml/xml.dart' as xml;

class XMLExampleUI extends StatefulWidget {
  @override
  _XMLExampleUIState createState() => _XMLExampleUIState();
}

class _XMLExampleUIState extends State<XMLExampleUI> {
  var xmlString = '''
    <tut>
      <id>12345</id>
      <author>Nandakishor Valakunde</author>
      <title>Flutter POC</title>
      <publish_date>2021-2-05</publish_date>
      <description>Description for FlutterPOC</description>
    </tut>''';
  var xmlStringList = '''<?xml version="1.0"?>
    <site>
      <tut>
      <id>12345</id>
      <author>Nandakishor Valakunde</author>
      <title>Flutter POC</title>
      <publish_date>2021-2-05</publish_date>
      <description>Description for FlutterPOC</description>
    </tut>
      <tut>
      <id>123456</id>
      <author>Sujay Patil</author>
      <title>Flutter POC</title>
      <publish_date>2021-2-06</publish_date>
      <description>Description for FlutterPOC 2</description>
    </tut>
    </site>''';

// TODO: BUILD XML FILE
  Future<HttpClientResponse> _sendXMLDataToServer() async {
    var builder = new xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="iso-8859-9"');
    builder.element('MainmsgBody', nest: () {
      builder.element('author', nest: "Nandakishor Valakunde");
      builder.element('title', nest: "Flutter POC");
      builder.element('publish_date', nest: "2021-2-05");
      builder.element('description', nest: "Description for FlutterPOC");
    });
    var bookshelfXml = builder.build();
    String _uriMsj = bookshelfXml.toString();
    print("_uriMsj: $_uriMsj");

    String _uri = "";
    var _responseOtp = postOTP(_uri, _uriMsj);
    print("_responseOtp: $_responseOtp");
  }

  // TODO: POST XML FILE
  Future<String> postOTP(String _uri, String _message) async {
    HttpClient client = new HttpClient();
    HttpClientRequest request = await client.postUrl(Uri.parse(_uri));
    request.write(_message);
    HttpClientResponse response = await request.close();
    StringBuffer _buffer = new StringBuffer();
    await for (String a in await response.transform(utf8.decoder)) {
      _buffer.write(a);
    }
    print("_buffer.toString: ${_buffer.toString()}");
    return _buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XML Example'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(xmlString),
          ),
          Container(
            child: RaisedButton(
              color: themeColorBlue,
              child: Text(
                "Send XML to Server",
                style: txtStyle(14, whiteColor),
              ),
              onPressed: () {
                _sendXMLDataToServer();
              },
            ),
          )
        ],
      ),
    );
  }
}
