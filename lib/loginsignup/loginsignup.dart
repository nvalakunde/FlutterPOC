import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/loginsignup/resetpassword.dart';
import 'dart:math';
import 'dart:convert';

import 'package:flutter_poc/responsivescreen/responsive.dart';

bool buttonpressed = false;
TextEditingController emailController = TextEditingController();
TextEditingController emailController1 = TextEditingController();
TextEditingController passwordController = TextEditingController();
PageController _pageController;
Color left = Colors.black;
Color right = Colors.white;

bool _autoValidate = false;
bool _isLoading = false;
String _email;
String _mobileno;

bool _autoValidateparent = false;
bool _isLoadingparent = false;

bool policy = false;
bool _obscureTextSignup = true;
bool _obscureTextSignupConfirm = true;

TextEditingController loginPasswordController = TextEditingController();
TextEditingController mobileController = TextEditingController();

final FocusNode myFocusNodeEmailLogin = FocusNode();
final FocusNode myFocusNodePasswordLogin = FocusNode();
final FocusNode parentemail = FocusNode();
final FocusNode parentmobile = FocusNode();
final FocusNode myFocusNodeName = FocusNode();

class Login extends StatefulWidget {
  final String msg;

  const Login({Key key, this.msg}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Login>
    with SingleTickerProviderStateMixin {
//class Login extends StatelessWidget {

  PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _autoValidate = false;
  bool _isLoading = false;
  String _password;
  String _email;
  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateInputsparent() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _autoValidateparent = true;
        _isLoadingparent = true;
      });
    } else {
      setState(() {
        _autoValidateparent = false;
        _isLoadingparent = false;
      });
    }
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      buttonpressed = true;
      setState(() {
        _autoValidate = true;
      });
    } else {
      setState(() {
        _autoValidate = false;
        _isLoading = false;
      });
    }
  }

  String validatepassword(String value) {
    if (value.length == 0) return 'Please Enter password';
  }

  String validateEmail(String value) {
    if (value.length == 0) return 'Please Enter email';
// if (!regex.hasMatch(value))
//   return 'Enter Valid Email';
// else {
//   return null;
// }
  }

  String validateusername(String value) {
    if (value.length == 0) return 'Please Enter username';
// if (!regex.hasMatch(value))
//   return 'Enter Valid Email';
// else {
//   return null;
// }g
  }

  String validatePassword(String value) {
    if (value.length == 0)
      return 'Please Enter Password';
    else {
      return null;
    }
  }

  void initState() {
    buttonpressed = false;
    if (widget.msg != null)
      new Future<Null>.delayed(Duration.zero, () {
        setState(() {
          scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(widget.msg),
              duration: Duration(seconds: 3),
            ),
          );
//Navigator.pop(context);
        });
      });
    super.initState();
//CheckLoginController.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              // physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: setHeight(75.0)),
                      child: new Image(
                          // width: MediaQuery.of(context).size.width * 0.9,
                          height: setHeight(100),
                          fit: BoxFit.fill,
                          image: new AssetImage(
                              'assets/images/default-image.jpg')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: setHeight(20.0)),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      // width: setWidth(360),
      width: MediaQuery.of(context).size.width * 0.83,
      height: MediaQuery.of(context).size.height * 0.083,
      decoration: BoxDecoration(
        color: themeColorYellow,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: left,
                      fontSize: setFontSize(16.0),
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            Container(
                // height: setHeight(30.0),
                width: setWidth(2.0),
                color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Center(
                  child: Text(
                    "Parent Signup",
                    style: TextStyle(
                        color: right,
                        fontSize: setFontSize(16.0),
                        fontFamily: "WorkSansSemiBold"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: setHeight(23.0)),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 8.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: setHeight(5.0),
                            bottom: setHeight(10.0),
                            left: setWidth(25.0),
                            right: setWidth(25.0)),
                        child: TextFormField(
                          focusNode: myFocusNodeEmailLogin,
                          // style: txtStyle(14, Colors.black,
                          //     fontWeight: FontWeight.bold),
                          controller: emailController,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(myFocusNodePasswordLogin),
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            icon: Icon(Icons.person),
                          ),
                          keyboardType: TextInputType.text,
                          validator: validateusername,
                          onSaved: (String val) {
                            _email = val;
                            //makeRequest(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: setHeight(5.0),
                            bottom: setHeight(10.0),
                            left: setWidth(25.0),
                            right: setWidth(25.0)),
                        child: TextFormField(
                          focusNode: myFocusNodePasswordLogin,
                          //validator: validatepassword,
                          obscureText: _obscureText,
                          // style: txtStyle(14, Colors.black,
                          //     fontWeight: FontWeight.bold),
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: themeColorBlue,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: validatePassword,
                          onSaved: (String val) {
                            _password = val;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(right: setWidth(30)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text('Forgot Password ?',
                                style: txtStyle(12, themeColorYellow)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: setHeight(330), bottom: setHeight(10)),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [gradient_linear1, gradient_linear2],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: themeColorYellow,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 80.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: setFontSize(16.0),
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   "/AttendanceDashboard",
                        // );
                        setState(() {
                          _isLoading = true;
                        });
                        _validateInputs();
                        String mystatus;
                        if (_autoValidate) {
                          
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(mystatus),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                        }
                      })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: setHeight(23.0)),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 8.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: setHeight(5.0),
                            bottom: setHeight(10.0),
                            left: setWidth(25.0),
                            right: setWidth(25.0)),
                        child: TextFormField(
                          controller: emailController1,
                          focusNode: parentemail,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(parentmobile),
                          decoration: const InputDecoration(
                            labelText: 'Enter valid Email',
                            icon: Icon(Icons.mail),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmailparent,
                          onSaved: (String val) {
                            _email = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: setHeight(5.0),
                            bottom: setHeight(10.0),
                            left: setWidth(25.0),
                            right: setWidth(25.0)),
                        child: TextFormField(
                          controller: mobileController,
                          focusNode: parentmobile,
                          decoration: const InputDecoration(
                            labelText: 'Enter Valid Mobile No',
                            icon: Icon(Icons.phone_android),
                          ),
                          keyboardType: TextInputType.number,
                          validator: validateMobile,
                          onSaved: (String val) {
                            _mobileno = val;
                          },
                        ),
                      ),
                      CheckboxListTile(
                        title: new Text("Policy"),
                        value: policy,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool value) {
                          setState(() {
                            policy = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              _isLoadingparent == true
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColorYellow)),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: setHeight(330.0)),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: new LinearGradient(
                            colors: [gradient_linear1, gradient_linear2],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: themeColorYellow,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: setHeight(10.0),
                              bottom: setHeight(10.0),
                              left: setWidth(80.0),
                              right: setWidth(80.0)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: setFontSize(15.0),
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          _validateInputsparent();
                          
                        },
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  String validateEmailparent(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else {
      return null;
    }
  }

  String validateMobile(String value) {
    if (mobileController.text.length == 0)
      return 'Enter your 10 digit mobile number';
    else if (mobileController.text.length < 10 ||
        mobileController.text.length > 10)
      return 'Enter your 10 digit mobile number';
    else {
      return null;
    }
  }

  String validateMobileparent(String value) {
    if (mobileController.text.length == 0)
      return 'Enter your 10 digit mobile number';
    else if (mobileController.text.length < 10 ||
        mobileController.text.length > 10)
      return 'Enter your 10 digit mobile number';
    else {
      return null;
    }
  }
}

class TabIndicationPainter extends CustomPainter {
  Paint painter;
  final double dxTarget;
  final double dxEntry;
  final double radius;
  final double dy;

  final PageController pageController;

  TabIndicationPainter(
      {this.dxTarget = 125.0,
      this.dxEntry = 25.0,
      this.radius = 21.0,
      this.dy = 25.0,
      this.pageController})
      : super(repaint: pageController) {
    painter = new Paint()
      ..color = Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final pos = pageController.position;
    double fullExtent =
        (pos.maxScrollExtent - pos.minScrollExtent + pos.viewportDimension);

    double pageOffset = pos.extentBefore / fullExtent;

    bool left2right = dxEntry < dxTarget;
    Offset entry = new Offset(left2right ? dxEntry : dxTarget, dy);
    Offset target = new Offset(left2right ? dxTarget : dxEntry, dy);

    Path path = new Path();
    path.addArc(
        new Rect.fromCircle(center: entry, radius: radius), 0.5 * pi, 1 * pi);
    path.addRect(
        new Rect.fromLTRB(entry.dx, dy - radius, target.dx, dy + radius));
    path.addArc(
        new Rect.fromCircle(center: target, radius: radius), 1.5 * pi, 1 * pi);

    canvas.translate(size.width * pageOffset, 0.0);
    canvas.drawShadow(path, Colors.black, 3.0, true);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(TabIndicationPainter oldDelegate) => true;
}
