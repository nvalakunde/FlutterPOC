import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

Widget dropDownUI(
    String selectedValue, List<String> dropDownValues, State state) {
  return Container(
    margin: EdgeInsets.all(10),
    child: DropdownButton<String>(
      hint: Text("Choose Value"),
      underline: SizedBox(),
      isExpanded: true,
      value: selectedValue,
      onChanged: (String newValue) {
        state.setState(() {
          selectedValue = newValue;
        });
      },
      items: dropDownValues.map((String dropValue) {
        return new DropdownMenuItem<String>(
          value: dropValue,
          child: Row(
            children: <Widget>[
              new Text(
                dropValue,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

Widget textFieldUI(TextEditingController textController, {String fieldName}) {
  return Container(
    margin: EdgeInsets.all(setHeight(10)),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
            width: 2.0, style: BorderStyle.solid, color: themeColorBlue),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
    ),
    child: TextFormField(
      controller: textController,
      // initialValue: "55",
      textInputAction: TextInputAction.go,
      // keyboardType: inputk,
      decoration:
          InputDecoration(labelText: fieldName, fillColor: Colors.amber),
    ),
  );
}

Widget textFieldAreaUI(TextEditingController textController) {
  return TextFormField(
    controller: textController,
    textInputAction: TextInputAction.go,
    minLines: 2,
    maxLines: 3,
    decoration:
        InputDecoration(labelText: 'Text Area', fillColor: Colors.amber),
  );
}

class DemoSelected {
  bool selected;
  String name;

  DemoSelected(bool selected, String name) {
    this.selected = selected;
    this.name = name;
  }
}

Widget collasibleOptionChoose(List<DemoSelected> demoList) {
  return Container(
    margin: EdgeInsets.all(10),
    child: Card(
      elevation: 9,
      child: ExpansionTile(
        title: Text('Collapsible Choose Menu'),
        leading: Icon(Icons.local_pizza),
        trailing: Icon(Icons.expand_more),
        children: <Widget>[
          Column(
            children: <Widget>[
              ListView.builder(
                  itemCount: demoList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext contex, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: demoList[index].selected,
                            onChanged: (value) {
                              setState() {
                                demoList[index].selected = value;
                              }
                            },
                          ),
                          Text('${demoList[index].name}'),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    ),
  );
}
