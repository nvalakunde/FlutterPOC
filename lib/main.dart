import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/Stateful_Widgets/checkboxcombo.dart';
import 'package:flutter_poc/Stateful_Widgets/passwordwidget.dart';
import 'package:flutter_poc/alertwidgets/show_dialog.dart';
import 'package:flutter_poc/analyticsandchart/charts.dart';
import 'package:flutter_poc/cascadedropdown/cascadeui.dart';
import 'package:flutter_poc/colorchoose/colorchooseui.dart';
import 'package:flutter_poc/datetimecal.dart/datepicker.dart';
import 'package:flutter_poc/input.dart/fileattach.dart';
import 'package:flutter_poc/input.dart/input.dart';
import 'package:flutter_poc/loginsignup/loginsignup.dart';
import 'package:flutter_poc/media/imageoperation.dart';
import 'package:flutter_poc/navigation/navigatanimation.dart';
import 'package:flutter_poc/pdfcreate/createpdf.dart';
import 'package:flutter_poc/pdfcreate/pdrwriter.dart';
import 'package:flutter_poc/qrcoder/qrscanner.dart';
import 'package:flutter_poc/repeatwidgets.dart/gridUI.dart';
import 'package:flutter_poc/repeatwidgets.dart/reaptscreen.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/searchoperation/searchastype.dart';
import 'package:flutter_poc/searchoperation/searchui.dart';
import 'package:flutter_poc/settings/settings.dart';
import 'package:flutter_poc/signature/signaturepad.dart';
import 'package:flutter_poc/signature/sketchpad.dart';
import 'package:flutter_poc/tabledata/tableui.dart';
import 'package:flutter_poc/taskmanagement/screens/taskDashboard.dart';
import 'package:flutter_poc/utils/constantData.dart';
import 'package:flutter_poc/webviewpage.dart/webviewscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController myText1 = TextEditingController();
  TextEditingController myText2 = TextEditingController();
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  TextEditingController number3 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());
  Offset _dragDownOffset;
  Timer _timer;
  int _start = 50;
  List<DemoSelected> demoSelectedList = [
    DemoSelected(false, "Large Pizza"),
    DemoSelected(true, "Medium Pizza"),
    DemoSelected(false, "Small Pizza"),
  ];
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setDeviceData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("FLUTTER POC"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(top: 10),
            child: companyLogo(
              "https://res.cloudinary.com/demo/image/upload/v1312461204/sample.jpg",
              150,
              150,
            ),
          ),
          textFieldUI(myText1),
          textFieldAreaUI(myText2),
          RaisedButton(
            color: themeColorBlue,
            onPressed: () {
              showMaterialDialog(context);
            },
            child: Text('Show Material Dialog'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              showCupertinoDialog(context);
            },
            child: Text('Show Cupertino Dialog'),
          ),

          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatePickerUI(),
                ),
              );
            },
            child: Text('Date Picker'),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              RaisedButton(
                onPressed: () {
                  selectDate(context).then((value) {
                    setState(() {
                      if (value != null) selectedDate = value;
                    });
                  });
                },
                child: Text('Select date'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  launchURL("https://www.google.com");
                },
                child: Text("https://www.google.com"),
              ),
              Container(
                child: Text('Tap on url to launch'),
              ),
            ],
          ),
          Container(
            child: Row(
              children: [
                Expanded(child: collasibleOptionChoose(demoSelectedList))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("$selectedTime"),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    selectTime(context).then((value) {
                      if (value != null) {
                        setState(() {
                          print(value);
                          selectedTime = value;
                        });
                      }
                    });
                  });
                },
                child: Text('Select Time'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("$_start Sec"),
              RaisedButton(
                onPressed: () {
                  startTimer();
                },
                child: Text("start"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 80,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorBlue),
                    ),
                  ),
                  controller: number1,
                ),
              ),
              Container(
                child: Text("+"),
              ),
              Container(
                width: 80,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColorBlue),
                    ),
                  ),
                  controller: number2,
                ),
              ),
              Container(
                width: 50,
                child: TextField(
                  controller: number3,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  int num1 = int.parse(number1.text);
                  int num2 = int.parse(number2.text);
                  if (num1 != null && num2 != null)
                    setState(() {
                      number3.text = (num1 + num2).toString();
                    });
                },
                child: Text("Add"),
              ),
            ],
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignaturePad(),
                ),
              );
            },
            child: Text('SignaturePad'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CascadeUI(),
                ),
              );
            },
            child: Text('Cascade Choise UI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChooseColorUI(),
                ),
              );
            },
            child: Text('Color Choose UI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImagePickerUI(),
                ),
              );
            },
            child: Text('ImagePickerUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: Text('LoginSignup UI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeUI(),
                ),
              );
            },
            child: Text('QRCodeUI'),
          ),
          Container(
              // child:GestureDetector(
              // key: _gestureDetectorKey,
              // onHorizontalDragUpdate: _move,
              // onHorizontalDragEnd: _settle,
              // behavior: HitTestBehavior.translucent,
              // excludeFromSemantics: true,
              // dragStartBehavior: widget.dragStartBehavior,
              // child: Container(width: dragAreaWidth),
              ),

          // GestureDetector(
          //   onHorizontalDragUpdate: (DragUpdateDetails details) {
          //     //* User dragged only from left to right of screen

          //     if (_dragDownOffset.dx < 60.0 && details.delta.dx > 0) {
          //       //  Navigator.push(context, NavigateDrawerUI(previousPage: null, builder: (context) => AmplifyMapsFeature()));
          //       //   Navigator.of(context).push(
          //       //     AmplifyPageRoute(
          //       //       page: () => AmplifyMapsFeature(),
          //       //       transition: Transition.leftToRight,
          //       //       transitionDuration: Duration(milliseconds: 600),
          //       //     ),
          //       //   );
          //     }

          //     //! This [onHorizontalDragUpdate] overrides changing tabs on swipe
          //     //TODO Add callback methods to change tabs.
          //   },
          //   onPanDown: (DragDownDetails details) {
          //     setState(() {
          //       _dragDownOffset = details.localPosition;
          //     });
          //   },
          //   child: Container(),
          // ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigateDrawerUI(),
                ),
              );
            },
            child: Text('NavigateDrawerUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FileAttachUI(),
                ),
              );
            },
            child: Text('FileAttachUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChartUI(),
                ),
              );
            },
            child: Text('ChartUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskHome(),
                ),
              );
            },
            child: Text('TaskHome'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingUI(),
                ),
              );
            },
            child: Text('SettingUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFOperationUI(),
                ),
              );
            },
            child: Text('PDFOperationUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFPrintUI(),
                ),
              );
            },
            child: Text('Print PDF'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableViewUI(),
                ),
              );
            },
            child: Text('TableViewUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchListUI(),
                ),
              );
            },
            child: Text('SearchListUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchListAsTypeUI(),
                ),
              );
            },
            child: Text('SearchListAsTypeUI'),
          ),
          RaisedButton(
            color: themeColorYellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SketchPadUI(),
                ),
              );
            },
            child: Text(
              'SketchPadUI',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          RaisedButton(
            color: themeColorRedBrown,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewPage("Facebook", "https://www.facebook.com"),
                ),
              );
            },
            child: Text(
              'Web View',
            ),
          ),
          RaisedButton(
            color: themeColorRedBrown,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RepeatWidget()),
              );
            },
            child: Text(
              'ADD DELETE REPEAT',
            ),
          ),
          RaisedButton(
            color: themeColorRedBrown,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckBoxUI()),
              );
            },
            child: Text(
              'Checkbox Demo',
            ),
          ),
          RaisedButton(
            color: themeColorRedBrown,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFormUI()),
              );
            },
            child: Text(
              'Form UI Demo',
            ),
          ),
          gridUI(13),
          // Container(
          //   height: 100,
          //   width: 400,
          //   child: PasswordWidget(emailRegex)),
        ],
      ),
    );
  }
}
