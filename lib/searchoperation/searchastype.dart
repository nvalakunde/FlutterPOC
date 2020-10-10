import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/models/cricket.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';

class SearchListAsTypeUI extends StatefulWidget {
  @override
  _SearchListAsTypeUIState createState() => _SearchListAsTypeUIState();
}

class _SearchListAsTypeUIState extends State {
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
    // editingSearchController.addListener(() {
    //   setState(() {
    //     filter = editingSearchController.text;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("SearchListAsTypeUI"),
      ),
      body: ListView(
        children: [
          // Container(
          //   margin: EdgeInsets.only(left: setHeight(8), right: setHeight(8)),
          //   child: Card(
          //     margin: EdgeInsets.all(setHeight(10)),
          //     child: Container(
          //       child: TextField(
          //         style: txtStyle(14, Colors.black),
          //         controller: editingSearchController,
          //         onChanged: (value) {},
          //         decoration: InputDecoration(
          //           prefixIcon: Icon(Icons.search),
          //           border: InputBorder.none,
          //           labelStyle: txtStyle(14, Colors.black54),
          //           labelText: 'Search Course by Course Name',
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: editingSearchController,
                    decoration: InputDecoration(hintText: 'Search...'),
                    onChanged: (v) {
                      setState(() {
                        filter = v;
                        setResults(filter);
                      });
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: filter.isEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _cricketerList.length,
                          itemBuilder: (con, ind) {
                            return ListTile(
                              title: Text(_cricketerList[ind].name),
                              subtitle: Text(_cricketerList[ind].hS),
                              onTap: () {
                                setState(() {
                                  editingSearchController.text = _cricketerList[ind].name;
                                  filter = _cricketerList[ind].hS;
                                  setResults(filter);
                                });
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _cricketerListResults.length,
                          itemBuilder: (con, ind) {
                            return ListTile(
                              title: Text(_cricketerListResults[ind].name),
                              subtitle: Text("High Score : "+_cricketerListResults[ind].hS),
                              onTap: () {
                                setState(() {
                                  editingSearchController.text = _cricketerListResults[ind].name;
                                  filter = _cricketerListResults[ind].hS;
                                  setResults(filter);
                                });
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
          // Container(
          //   width: screenWidth,
          //   padding: EdgeInsets.all(setHeight(10.0)),
          //   child: new ListView.builder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: _cricketerList.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return _cricketerList[index].name.toLowerCase().contains(
          //                 filter.toLowerCase(),
          //               )
          //           ? Container(
          //               child: Card(
          //                 child: Text("${_cricketerList[index].name}"),
          //               ),
          //             )
          //           : Container();
          //     },
          //   ),
          // ),
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