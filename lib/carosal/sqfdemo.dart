import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/carosal/databasehelper.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';

class Children {
  String name;
  int id;
  int age;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  Children.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    name = map['name'];
    age = map['age'];
  }
}

class SQFLiteDemo extends StatefulWidget {
  @override
  _SQFLiteDemoState createState() => new _SQFLiteDemoState();
}

class _SQFLiteDemoState extends State<SQFLiteDemo> {
  List<Map<String, dynamic>> myDatabaseList = [];
  List<Children> myChildrenList = [];
  TextEditingController myChildrens = TextEditingController();
  List<TextEditingController> myChildrensNames = [];
  List<TextEditingController> myChildrensAges = [];
  int numberOfChilds = 0;
  @override
  void initState() {
    setState(() {
      _query().then((value) {
        if (this.mounted) {
          setState(() {
            myChildrenList = value;
          });
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  queryData() {
    setState(() {
      _query().then((value) {
        if (this.mounted) {
          myChildrenList = [];
          setState(() {
            myChildrenList = value;
          });
        }
      });
    });
  }

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(
          height: setHeight(20),
        ),
        Container(
          child: Column(
            children: [
              Text("How Many Childrens Do You Have ?"),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: myChildrens,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          labelText: 'Text Field', fillColor: Colors.amber),
                    )),
                    RaisedButton(
                      color: themeColorYellow,
                      onPressed: () {
                        print(myChildrens.text);
                        setState(() {
                          try {
                            numberOfChilds = int.parse(myChildrens.text);
                            myChildrensNames =
                                List<TextEditingController>(numberOfChilds);
                            myChildrensAges =
                                List<TextEditingController>(numberOfChilds);
                          } catch (e) {}
                        });
                      },
                      child: Text("Insert"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: setHeight(20),
        ),
        numberOfChilds == 0
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.only(top: 5.0),
                itemCount: numberOfChilds,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: buildChildUI(index),
                  );
                }),
        SizedBox(
          height: setHeight(20),
        ),
        myChildrenList.length == 0
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                // padding: EdgeInsets.only(top: 5.0),
                itemCount: myChildrenList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: buildChildrenDisplay(myChildrenList[index]),
                  );
                }),
      ],
    );
  }

  Widget buildChildrenDisplay(Children children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Name :: ${children.name}",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Age :: ${children.age}",
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                _delete(children.id);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildChildUI(int index) {
    myChildrensNames[index] = TextEditingController();
    myChildrensAges[index] = TextEditingController();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(setHeight(10)),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: themeColorBlue),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: myChildrensNames[index],
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                      labelText: "   Name", fillColor: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(setHeight(10)),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: themeColorBlue),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: myChildrensAges[index],
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(
                      labelText: "   Age", fillColor: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            color: themeColorBlue,
            onPressed: () {
              if (myChildrensNames[index].text.trim() != "" &&
                  myChildrensAges[index].text.trim() != "") {
                setState(() {
                  _insert(myChildrensNames[index].text.trim(),
                      int.parse(myChildrensAges[index].text.trim()));
                });
              } else {
                toastFunstion(context, "Insert Name & Age");
              }
            },
            child: Text(
              "Insert Data",
              style: txtStyle(12, whiteColor),
            ),
          ),
        )
      ],
    );
  }

  void _insert(String name, int age) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAge: age
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    setState(() {
      queryData();
    });
  }

  Future<List<Children>> _query() async {
    List<Map> maps = await dbHelper.queryAllRows();

    List<Children> children = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print("maps[i]");
        print(maps[i]);
        children.add(Children.fromMap(maps[i]));
      }
    }

    return children;
  }

  void _update(int id, String name, int age) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnAge: age
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
    setState(() {
      queryData();
    });
  }

  void _delete(int id) async {
    print(id);
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    setState(() {
      queryData();
    });
  }
}
