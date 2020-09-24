import 'package:flutter/material.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

class DropDownWidget extends StatefulWidget {
  String selectedItem;
  final List<String> dropdownListItems;

  DropDownWidget(this.selectedItem, this.dropdownListItems);
  _DropDownWidgetState createState() => new _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  
  String selectedValue;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValue=widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(setHeight(20)),
      child: DropdownButton<String>(
        hint: Text("Choose Value"),
        underline: SizedBox(),
        isExpanded: true,
        value: selectedValue,
        onChanged: (String newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        items: widget.dropdownListItems.map((String dropValue) {
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
}
