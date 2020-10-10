import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/loginsignup/checkforgototp.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/utils/constantData.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class ForgotPassword extends StatefulWidget {
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<ForgotPassword> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = true;

  String validateEmail(String value) {
    if (!emailRegex.hasMatch(value))
      return 'Enter Valid Email';
    else {
      return null;
    }
  }

  void makeRequest() {
    String email = emailController.text;
    if (email != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckForgotOtp(
            email: email,
          ),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget middleSection = new Expanded(
      child: new Container(
        padding: new EdgeInsets.all(30.0),
        color: Colors.white,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: companyLogo(
                "https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg",
                150,
                150,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextFormField(
                autofocus: true,
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                // onChanged: (String val) {
                //   _email = val;
                // },
              ),
            ),
            Container(
              height: setHeight(50),
              margin: EdgeInsets.only(
                  top: setHeight(20),
                  bottom: setHeight(10),
                  right: setWidth(50),
                  left: setWidth(50)),
              child: loading == true
                  ? Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(themeColorBlue),
                    ))
                  : RaisedButton(
                      child: Text(
                        "Get OTP on Email",
                      ),
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });

                        makeRequest();
                      },
                    ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Send OTP",
        ),
      ),
      body: Center(
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: middleSection,
        ),
      ),
    );
  }
}
