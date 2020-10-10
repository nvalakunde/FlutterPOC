import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/loginsignup/loginsignup.dart';
import 'package:http/http.dart' as http;

// Note: for simplicity, this is a stateless widget but, in a real app,
// a full screen is likely to be a stateful widget.
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController fnameController = TextEditingController();
TextEditingController lnameController = TextEditingController();



class ChangePassword extends StatefulWidget {
  final String email;
  _ChangePasswordState createState() => new _ChangePasswordState(email:email);
  ChangePassword({Key key, @required this.email}) : super(key: key);
}
class _ChangePasswordState extends State<ChangePassword> {
  Future<Null> makeRequest(BuildContext context) async {
  String url = "changePassword";
  String email = 'email=' + emailController.text;
  print(emailController.text);
  String password='&password='+passwordController.text;
  if (true) {
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Login(msg: "Password Changed Successfully",)));
  }
  else{
         new Future<Null>.delayed(Duration.zero, () {
      setState(() {
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("You Need to registered First"),
                duration: Duration(seconds: 3),
              ),
            );
            //Navigator.pop(context);
          });
    });
  }
}
  String email;
   _ChangePasswordState({Key key, @required this.email}) : super();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = true;
  
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
      _autoValidate = true;
    });
  }
  }
  void showSnakBar(){
     new Future<Null>.delayed(Duration.zero, () {
      setState(() {
            scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("You Need to registered First"),
                duration: Duration(seconds: 3),
              ),
            );
            //Navigator.pop(context);
          });
    });
  }
  String validatePassword(String value) {
     return null;
  }
  String validateConfirmPassword(String value) {
    if (passwordController.text!=confirmController.text)
      return 'Not maching';
    else{
      _autoValidate=false;
      return null;
    }   
  }
  

  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    //passwordController.text = '';
    //passwordController.text = '';

    Widget middleSection =  Container(
        padding: new EdgeInsets.all(30.0),
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: 
              TextFormField(
                style:TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                //initialValue: this._email,
                enabled: false,
                //keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: 
              TextFormField(
                obscureText: true,
                style:TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.text,
                validator: validatePassword,
                onSaved: (String val) {
                 // _password = val;
                  //makeRequest(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: 
              TextFormField(
                obscureText: true,
                style:TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: confirmController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                keyboardType: TextInputType.text,
                validator: validateConfirmPassword,
                onSaved: (String val) {
                //_confirmpasswo = val;
                  
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: RaisedButton(
                  child: Text(
                    "Change Password",
                  ),
                  onPressed:(){
                    print("Chnage Clicked");
                      _validateInputs();
                      if(!_autoValidate)
                        makeRequest(context);
                  } 
                  
                  ),
            )
          ],
        ),
    );

    // Widget bottomBanner = new Container(
    //   padding: new EdgeInsets.only(left: 30.0, bottom: 30.0, right: 30.0),
    //   color: Colors.white,
    //   height: 68.0,
    //   child: new Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Expanded(
    //           child: Center(
    //         child: Text(
    //           "By creating an account, you agree to our terms and conditions and our privacy policy.",
    //           textDirection: TextDirection.ltr,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             decoration: TextDecoration.none,
    //             fontSize: 14.0,
    //             fontFamily: 'Roboto',
    //             fontWeight: FontWeight.w900,
    //             color: textPrimaryColor,
    //           ),
    //         ),
    //       )),
    //     ],
    //   ),
    // );
    Widget body = new Container(
      child:  middleSection,
    );

    return Scaffold(
        appBar: AppBar( iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          //actions: menu,
          title: Text(
            "Change Password",
            style: txtStyle(18, Colors.black,fontWeight: FontWeight.w700)
            
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
          context,
           MaterialPageRoute(
              builder: (context) => Login()),
        );
                // Write some code to control things, when user press back button in AppBar
              }),
        ),
        body: Center(
          child: new Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: body,
          ),
        ),
        //bottomNavigationBar: bottomBanner,
     );
  }
}