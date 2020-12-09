import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/models/dynamicFieldModel.dart';
import 'package:flutter_poc/utils/constantData.dart';
import 'package:http/http.dart' as http;

class FetchDyanamicUI extends StatefulWidget {
  @override
  _FetchDyanamicUIsState createState() => new _FetchDyanamicUIsState();
}

class _FetchDyanamicUIsState extends State<FetchDyanamicUI> {
  List<DynamicField> dynamicFieldList = [];
  DateTime selectedDate = DateTime.now();
  String _path;
  String _fileName;
  String _extension;
  @override
  void initState() {
    super.initState();
    fetchDyanamicData();
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

  fetchDyanamicData() async {
    dynamicFieldList = [];
    String url =
        "https://emportalapitest.azurewebsites.net/api/SelfServeReport/FlutterDemo?access_token=Flutter_test";
    // String url = "http://10.0.2.2:3000/fields";

    print("url : " + url);
    var response = await http.get(url, headers: {"Accept": "application/json"});
    print(response.body);
    var data = json.decode(response.body);
    DynamicField dynamicField;
    for (var eachField in data['fields']) {
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
          : SingleChildScrollView(
              child: Column(
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
                          child: buildFieldTypeUI(dynamicFieldList[index]));
                    },
                  ),
                ],
              ),
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

  // Widget buildFieldUI(DynamicField dynamicField) {
  //   return dynamicField.isApplicable
  //       ? Container(
  //           padding: EdgeInsets.all(10),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildFieldTypeUI(dynamicField),
  //             ],
  //           ),
  //         )
  //       : Container();
  // }

  Widget buildFieldTypeUI(DynamicField dynamicField) {
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
                dynamicField.feildType.toLowerCase() == "text"
                    ? TextField(
                        maxLength: dynamicField.limit,
                        keyboardType: getTextInputType(dynamicField.inputType),
                      )
                    : buildFieldUI(dynamicField),
              ],
            ),
          )
        : Container();
  }

  Widget buildFieldUI(DynamicField dynamicField) {
    int radioValue = 1;
    return dynamicField.feildType.toLowerCase() == "dropdown"
        ? Container(
            child: DropdownButton<ListData>(
              items: dynamicField.listData
                  .map((item) => DropdownMenuItem<ListData>(
                        child: Text(item.name),
                        value: item,
                      ))
                  .toList(),
              onChanged: (ListData value) {
                setState(() => dynamicField.value = value.name);
              },
              hint: Text('Choose Your Education '),
            ),
          )
        : dynamicField.feildType.toLowerCase() == "date"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${selectedDate.toLocal()}".split(' ')[0]),
                  RaisedButton(
                    onPressed: () {
                      selectDate(context).then((value) {
                        setState(() {
                          if (value != null) selectedDate = value;
                        });
                      });
                    },
                    child: Text('Select date'),
                  ),
                ],
              )
            : dynamicField.feildType.toLowerCase() == "file"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: _path != null
                            ? Text(
                                _fileName.length > 38
                                    ? _fileName.substring(0, 38) + "..."
                                    : "" + _fileName,
                                style: txtStyle(12, Colors.black54),
                              )
                            : Container(),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _openFileExplorer();
                        },
                        child: Text('Select file'),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dynamicField.listData != null
                        ? dynamicField.listData.length
                        : 0,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext contex, int index) {
                      return Container(
                        child: dynamicField.feildType.toLowerCase() ==
                                "checkbox"
                            ? CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: dynamicField.listData[index].selected,
                                // groupValue: dynamicField.isShow,
                                onChanged: (value) {
                                  setState(() {
                                    dynamicField.listData[index].selected =
                                        value;
                                  });
                                },
                                title: Text(dynamicField.listData[index].name),
                              )
                            : dynamicField.feildType.toLowerCase() == "radio"
                                ? RadioListTile(
                                    value: dynamicField.listData[index].name,
                                    groupValue: radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        // radioValue = index;
                                        // dynamicField.listData[index].selected = value;
                                        print("object");
                                        print(index);
                                        print(radioValue);
                                        print(dynamicField
                                            .listData[index].selected);
                                      });
                                    },
                                    title:
                                        Text(dynamicField.listData[index].name),
                                  )
                                : Container(),
                      );
                    },
                  );
  }
}
