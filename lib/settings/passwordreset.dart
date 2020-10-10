import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/loginsignup/loginsignup.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:http/http.dart' as http;

TextEditingController emailController = TextEditingController();
TextEditingController oldpasswordController = TextEditingController();
TextEditingController newpasswordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
TextEditingController mobileController = TextEditingController();
TextEditingController fnameController = TextEditingController();
TextEditingController lnameController = TextEditingController();

class PasswordReset extends StatefulWidget {
  final String email;
  _ChangePasswordState createState() => new _ChangePasswordState(email: email);
  PasswordReset({Key key, @required this.email}) : super(key: key);
}

class _ChangePasswordState extends State<PasswordReset> {
  String email;
  _ChangePasswordState({Key key, @required this.email}) : super();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool _oldObscureText = true;
  bool _newObscureText = true;
  bool _confirmObscureText = true;

  String _confirmpassword;
  @override
  void initState() {
    super.initState();
    oldpasswordController.text = '';
    newpasswordController.text = '';
    confirmController.text = '';
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validatePassword(String value) {
    if (value.length < 8) {
      return 'Password should be 8 character long';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (newpasswordController.text.isEmpty &&
        confirmController.text.isEmpty &&
        oldpasswordController.text.isEmpty) {
      return 'Passwords are empty';
    }
    if (newpasswordController.text != confirmController.text)
      return 'New Password and Confirm Password is unmaching';
    else if (confirmController.text == oldpasswordController.text) {
      return 'Old and New password is same';
    } else {
      _autoValidate = false;
      return null;
    }
  }

  Future<Null> makeRequest(BuildContext context) async {
    String url = "resetPassword url";
    String email = 'email=' + emailController.text;
    String oldpassword = '&oldpassword=' + oldpasswordController.text;
    String newpassword = '&newpassword=' + newpasswordController.text;

    url = url + email + oldpassword + newpassword;
    print(url);
    try {
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
      print(response.body);
      var reg = "success";
      if (reg == 'success') {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => Login(
                  msg: "Password Changed Successfully",
                )));
      } else if (reg == 'unsuccessful') {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Old password is incorrect'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = email;
    //passwordController.text = '';
    //passwordController.text = '';

    Widget middleSection = Container(
      padding: new EdgeInsets.all(30.0),
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(top: 10.0),
          //   child:
          //   TextFormField(
          //     style:TextStyle(
          //       fontSize: 18.0,
          //       fontFamily: 'Roboto',
          //       fontWeight: FontWeight.bold,
          //     ),
          //     controller: emailController,
          //     decoration: const InputDecoration(labelText: 'Email'),
          //     //initialValue: this._email,
          //     enabled: false,
          //     //keyboardType: TextInputType.emailAddress,
          //   ),
          // ),
          TextFormField(
            obscureText: _oldObscureText,
            style: txtStyle(14.0, Colors.black, fontWeight: FontWeight.bold),
            controller: oldpasswordController,
            decoration:  InputDecoration(labelText: 'Old Password',
            suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _oldObscureText ? Icons.visibility_off : Icons.visibility,
                        color: themeColorBlue,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _oldObscureText = !_oldObscureText;
                        });
                      },
                    ),
            ),
            keyboardType: TextInputType.text,
            //validator: validatePassword,
            onSaved: (String val) {
              // _password = val;
              //makeRequest(context);
            },
          ),
          SizedBox(
            height: setHeight(15),
          ),
          TextFormField(
            obscureText: _newObscureText,
            style: txtStyle(14.0, Colors.black, fontWeight: FontWeight.bold),
            controller: newpasswordController,
            decoration: InputDecoration(labelText: 'New Password',
            suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _newObscureText ? Icons.visibility_off : Icons.visibility,
                        color: themeColorBlue,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _newObscureText = !_newObscureText;
                        });
                      },
                    ),
            ),
            keyboardType: TextInputType.text,
            validator: validatePassword,
            onSaved: (String val) {
              // _password = val;
              //makeRequest(context);
            },
          ),

          SizedBox(
            height: setHeight(15),
          ),
          TextFormField(
            obscureText: _confirmObscureText,
            style: txtStyle(14.0, Colors.black, fontWeight: FontWeight.bold),
            controller: confirmController,
            decoration: InputDecoration(labelText: 'Confirm Password',
            suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _confirmObscureText ? Icons.visibility_off : Icons.visibility,
                        color: themeColorBlue,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _confirmObscureText = !_confirmObscureText;
                        });
                      },
                    ),
            ),
            keyboardType: TextInputType.text,
            validator: validateConfirmPassword,
            onSaved: (String val) {
              _confirmpassword = val;
            },
          ),
          SizedBox(
            height: setHeight(15),
          ),
          Container(
            //width: 180,
            width: setWidth(setWidth(280)),
            //margin: EdgeInsets.all(setHeight(10)),
            child: RaisedButton(
                child: Text(
                  "Change Password",
                ),
                onPressed: () {
                  _validateInputs();
                  if (!_autoValidate) makeRequest(context);
                }),
          )
        ],
      ),
    );
    Widget body = middleSection;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          //actions: menu,
          title: Text("Change Password",
              style: txtStyle(18, Colors.black, fontWeight: FontWeight.w700)),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
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
    );
  }
}
