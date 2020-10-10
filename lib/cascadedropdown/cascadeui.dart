import 'package:flutter/material.dart';
import 'package:flutter_poc/cascadedropdown/cascadmodel.dart';
import 'package:flutter_poc/repository/repository.dart';

class CascadeUI extends StatefulWidget {
  @override
  _CascadeUIState createState() => _CascadeUIState();
}

class _CascadeUIState extends State<CascadeUI> {
  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose ..";
  List<Map> getAll() => country;

  @override
  void initState() {
    _states = List.from(_states)..addAll(getStates());
    super.initState();
  }

  List<String> getStates() => country
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();
  getLocalByState(String state) => country
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.cityList)
      .expand((i) => i)
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CASCADE DROPDOWN UI"),
        elevation: 6,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                isExpanded: true,
                items: _states.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (value) => _onSelectedState(value),
                value: _selectedState,
              ),
              DropdownButton<String>(
                isExpanded: true,
                items: _lgas.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (value) => _onSelectedLGA(value),
                value: _selectedLGA,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose ..";
      _lgas = ["Choose .."];
      _selectedState = value;
      _lgas = List.from(_lgas)..addAll(getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }
}
