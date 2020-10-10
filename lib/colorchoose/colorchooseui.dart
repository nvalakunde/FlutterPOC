import 'package:flutter/material.dart';

class ChooseColorUI extends StatefulWidget {

  @override
  ChooseColorUIState createState() {
    return new ChooseColorUIState();
  }

}

class ChooseColorUIState extends State<ChooseColorUI> {
  List<ColorModel> _colors = [
    ColorModel(color: Colors.blue, colorName: "Blue"),
    ColorModel(color: Colors.purple, colorName: "Purple"),
    ColorModel(color: Colors.pink, colorName: "Pink"),
    ColorModel(color: Colors.teal, colorName: "Teal"),
    ColorModel(color: Colors.amber, colorName: "Amber"),
    ColorModel(color: Colors.brown, colorName: "Brown"),
  ];
  Color _selectedColor = Colors.red;
  String _selectedColorValue = "Red";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Chooser'),
      ),
      body: Container(
        // color: _selectedColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              
              child: DropdownButton<Color>(
                items: _colors
                    .map((color) => DropdownMenuItem<Color>(
                          child: Text(color.colorName),
                          value: color.color,
                        ))
                    .toList(),
                onChanged: (Color value) {
                  setState(() => _selectedColor = value);
                },
                hint: Text('Drop down with BG Color '),
              ),
            ),
            Expanded(child: Container(
              color:_selectedColor,
            ),),
          ],
        ),
      ),
    );
  }
}

//Create a Model class to hold key-value pair data
class ColorModel {
  String colorName;
  Color color;

  ColorModel({this.colorName, this.color});
}