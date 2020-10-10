import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/loginsignup/changepassword.dart';
import 'package:flutter_poc/loginsignup/loginsignup.dart';
import 'package:flutter_poc/utils/constantData.dart';
import 'package:http/http.dart' as http;

TextEditingController otpController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
String _email = "";
bool visibilityReGen = true;
int _count = 0;

class CheckForgotOtp extends StatefulWidget {
  final String email;
  final String msg;

  _CheckForgotOtpPageState createState() =>
      new _CheckForgotOtpPageState(email: email);
  CheckForgotOtp({
    Key key,
    @required this.email,
    this.msg,
  }) : super(key: key);
}

class _CheckForgotOtpPageState extends State<CheckForgotOtp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode fotp = FocusNode();
  final FocusNode fpass = FocusNode();
  final FocusNode fcpass = FocusNode();
  String email;
  //String _otp;

  _CheckForgotOtpPageState({Key key, @required this.email}) : super();
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  bool _autoValidate = false;
  void dispose() {
    fotp.dispose();
    fpass.dispose();
    fcpass.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("widget.msg");
    print(_scaffoldKey);
    if (widget.msg != null)
      new Future<Null>.delayed(Duration.zero, () {
        setState(() {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(widget.msg),
              duration: Duration(seconds: 3),
            ),
          );
          //Navigator.pop(context);
        });
      });
  }

  _onSubmit() {
    setState(() {
      visibilityReGen = false;
    });
  }

  String validatePassword(String value) {
    if (passwordController.text == "") {
      return "Enter password";
    }
  }

  String validateConfirmPassword(String value) {
    if (confirmController.text == "") {
      return "Enter Confirm password";
    }
    if (passwordController.text != confirmController.text)
      return 'Not maching';
    else {
      _autoValidate = false;
      return null;
    }
  }

  String validateOTP(String value) {
    if (value.length != 6)
      return 'OTP Number must be of 6 digit';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    //otpController.text = '';
    _email = this.email;
    Widget middleSection = new Expanded(
      child: new Container(
        padding: new EdgeInsets.all(30.0),
        color: Colors.white,
        child: new ListView(
          shrinkWrap: true,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10),
                child: companyLogo(
                    "https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg",
                    150,
                    150)),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: otpController,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
                keyboardType: TextInputType.number,
                validator: validateOTP,
                onSaved: (String val) {
                  //_otp = val;
                  // makeRequest(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.text,
                validator: validatePassword,
                onSaved: (String val) {
                  // _password = val;
                  //makeRequest(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
                controller: confirmController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                keyboardType: TextInputType.text,
                validator: validateConfirmPassword,
                onSaved: (String val) {
                  //_confirmpasswo = val;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: RaisedButton(
                child: Text(
                  "Change Password",
                ),
                onPressed: () {
                  cp();
                },
              ),
            ),
          ],
        ),
      ),
    );
    Widget body = new Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection,
        //bottomBanner,
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: new Form(
          key: _formKeys,
          autovalidate: _autoValidate,
          child: body,
        ),
      ),
    );
  }

  Future<Null> generateAgain(BuildContext context) async {
    String url = "forgotPassword";
    String email = 'email=' + _email;
    print(_email);
    url = url + email;
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);
    Otps signEmail = new Otps.fromJson(json.decode(response.body));
    print(signEmail.msg);
    //print(signEmail.email);

    if (signEmail.msg == 'OK') {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('OTP Generated Successfully check your email'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(signEmail.msg),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Widget regenerateButton(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
      child: OutlineButton(
        //width: 180,
        borderSide: BorderSide(color: shadow_color),
        textColor: btnTextColorBlue,
        child: Text("Generate OTP Again"),
        //elevation: 6.0,
        onPressed: () {
          if (_count == 0) {
            generateAgain(context);
            _count++;
            visibilityReGen = false;
          } else {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('OTP Generation Limit Reached'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Null> makeRequest(BuildContext context) async {
    String url = "verifyOtpAPI";
    String email = 'email=' + _email;
    String otp = '&otp=' + otpController.text;
    print(otpController.text);
    url = url + email + otp;
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);
    Otps otpValue = new Otps.fromJson(json.decode(response.body));
    print(otpValue.msg);

    int status = 0;
    if (otpValue.msg == 'OK') {
      status = 0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangePassword(email: _email)),
      );
    } else if (otpValue.msg == 'Not Matched') {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please try again'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      status = 1;
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please generate OTP again..'),
          duration: Duration(seconds: 3),
        ),
      );
    }
    if (status == 1) {}
  }

  void cp() {
    String data;
    var params = Map<String, String>();
    params["otp"] = otpController.text.toString();
    params["uid"] = email.toString();
    params["newpwd"] = confirmController.text.toString();
    var body;
    body['msg'] = 200;

    if (body['msg'] == '200') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Login(
                  msg: "Password Changed successfully",
                )),
      );
    } else if (body['msg'] == 'ONM') {
      toastFunstion(context, "OTP Not Matched!!");
    } else if (body['msg'] == 'LNF') {
      toastFunstion(context, "Login Not Found!!");
    } else if (body['msg'] == 'ONA') {
      toastFunstion(context, "OTP Not Avaliable!!");
    }
  }
}

void updateEmail() {}

class Otps {
  String msg;
  Otps({
    this.msg,
  });
  factory Otps.fromJson(Map<String, dynamic> parsedJson) {
    return Otps(
      msg: parsedJson['msg'],
    );
  }
}

class StudRegisterList {
  List<Organization> org;
  List<UserType> userType;
  StudRegisterList({this.org, this.userType});
  factory StudRegisterList.fromJson(Map<String, dynamic> parsedJson) {
    return StudRegisterList(
      org: parsedJson['org'],
      userType: parsedJson['usertype'],
    );
  }
}

class UserType {
  String userType;
  UserType({
    this.userType,
  });
  factory UserType.fromJson(Map<String, dynamic> parsedJson) {
    return UserType(
      userType: parsedJson['usertype'],
    );
  }
}

class Organization {
  String orgName;
  Organization({
    this.orgName,
  });
  factory Organization.fromJson(Map<String, dynamic> parsedJson) {
    return Organization(
      orgName: parsedJson['org'],
    );
  }
}
