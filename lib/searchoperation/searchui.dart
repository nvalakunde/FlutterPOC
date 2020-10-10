import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/models/cricket.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';

class SearchListUI extends StatefulWidget {
  @override
  _SearchListUIState createState() => _SearchListUIState();
}

class _SearchListUIState extends State {
  final PageController ctrl = PageController(initialPage: 1);
  TextEditingController editingSearchController;
  List<Cricketer> _cricketerList;
  List<Cricketer> _cricketerListResults=List<Cricketer>();
  String filter = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editingSearchController = new TextEditingController();
    var cricketerJson = jsonDecode(cricketerList) as List;
    _cricketerList =
        cricketerJson.map((tagJson) => Cricketer.fromJson(tagJson)).toList();
    editingSearchController.addListener(() {
      setState(() {
        filter = editingSearchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("SearchListUI"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: setHeight(8), right: setHeight(8)),
            child: Card(
              margin: EdgeInsets.all(setHeight(10)),
              child: Container(
                child: TextField(
                  style: txtStyle(14, Colors.black),
                  controller: editingSearchController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    labelStyle: txtStyle(14, Colors.black54),
                    labelText: 'Search Course by Course Name',
                  ),
                ),
              ),
            ),
          ),
         
          Container(
            width: screenWidth,
            padding: EdgeInsets.all(setHeight(10.0)),
            child: new ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _cricketerList.length,
              itemBuilder: (BuildContext context, int index) {
                return _cricketerList[index].name.toLowerCase().contains(
                          filter.toLowerCase(),
                        )
                    ? Container(
                      
                        // margin: EdgeInsets.all(10),
                        child: Card(
                          child: Container(
                             margin: EdgeInsets.all(setHeight(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${_cricketerList[index].name}"),
                                Text("Heigh Score : ${_cricketerList[index].hS}"),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
  void setResults(String query) {
    _cricketerListResults = _cricketerList
        .where((elem) =>
            elem.name
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            elem.hS
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
  }
}