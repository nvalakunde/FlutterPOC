import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/utils/constantData.dart';

class MyFormUI extends StatefulWidget {
  @override
  MyFormUIState createState() {
    return MyFormUIState();
  }
}

class MyFormUIState extends State<MyFormUI> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText=true;
  TextEditingController passwordController=TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  readOnly: true,
                  initialValue: "initial Data",
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                obscureText: _obscureText,
                controller: passwordController,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'password should be long',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: themeColorBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value){
                  if (!emailRegex.hasMatch(value.trim()))
            return 'Enter Valid Password';
          else {
            return null;
          }
                },
                onSaved: (String val) {
                  passwordController.text = val;
                },
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Everithing Fine')));
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

