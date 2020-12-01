import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/models/dynamicFieldModel.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:http/http.dart' as http;

class FetchDyanamicUI extends StatefulWidget {
  @override
  _FetchDyanamicUIsState createState() => new _FetchDyanamicUIsState();
}

class _FetchDyanamicUIsState extends State<FetchDyanamicUI> {
  List<DynamicField> dynamicFieldList = [];
  @override
  void initState() {
    super.initState();
    fetchDyanamicData();
  }

  fetchDyanamicData() async {
    dynamicFieldList = [];
    String url = "http://10.0.2.2:3000/fields";

    print("url : " + url);
    var response = await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    var data = json.decode(response.body) as List;
    DynamicField dynamicField;
    for (var eachField in data) {
      dynamicField = DynamicField.fromJson(eachField);
      dynamicFieldList.add(dynamicField);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: MyDrawer(currentProfilePic),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CatalogCourses()),
            // );
          },
        ),
        title: Text("FetchDyanamicUIs", style: txtStyle(18, Colors.black)),
        backgroundColor: themebkgColor,
        iconTheme: new IconThemeData(),
      ),
      body: dynamicFieldList.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColorYellow),
                  //backgroundColor: themeColorYellow,
                ),
              ),
            )
          : Column(
              children: [
                RaisedButton(
                  onPressed: () {
                    fetchDyanamicData();
                    setState(() {});
                  },
                  child: Text("Fetch Data"),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dynamicFieldList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext contex, int index) {
                    return Container(
                        child: buildFieldUI(dynamicFieldList[index]));
                  },
                ),
              ],
            ),
    );
  }

  getTextInputType(String type) {
    if (type == "number") {
      return TextInputType.number;
    } else if (type == "text") {
      return TextInputType.text;
    } else if (type == "email") {
      return TextInputType.emailAddress;
    } else if (type == "phone") {
      return TextInputType.phone;
    }
  }

  Widget buildFieldUI(DynamicField dynamicField) {
    return dynamicField.isApplicable
        ? Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${dynamicField.fieldName}",
                    ),
                    if (dynamicField.isMandatory)
                      Text(
                        " *",
                        style: txtStyle(14, Colors.red),
                      ),
                  ],
                ),
                TextField(
                  maxLength: dynamicField.limit,
                  keyboardType: getTextInputType(dynamicField.type),
                ),
              ],
            ),
          )
        : Container();
  }
}
