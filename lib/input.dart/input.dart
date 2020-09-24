import 'package:flutter/material.dart';

Widget dropDownUI(String selectedValue, List<String> dropDownValues,State state) {
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

Widget textFieldUI(TextEditingController textController) {
  return TextFormField(
    controller: textController,
    textInputAction: TextInputAction.go,
    decoration:
        InputDecoration(labelText: 'Text Field', fillColor: Colors.amber),
  );
}
Widget textFieldAreaUI(TextEditingController textController) {
  return TextFormField(
    controller: textController,
    textInputAction: TextInputAction.go,
    minLines: 4,
    maxLines: 4,
    decoration:
        InputDecoration(labelText: 'Text Area', fillColor: Colors.amber),
  );
}
