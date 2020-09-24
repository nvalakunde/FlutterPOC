import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/Stateful_Widgets/buttonwidgets/RaisedGradientButton.dart';
import 'package:flutter_poc/Stateful_Widgets/checkboxcombo.dart';
import 'package:flutter_poc/Stateful_Widgets/dropdown/dropdownwidget.dart';
import 'package:flutter_poc/Stateful_Widgets/passwordwidget.dart';
import 'package:flutter_poc/alertwidgets/show_dialog.dart';
import 'package:flutter_poc/datetimecal.dart/calendar.dart';
import 'package:flutter_poc/input.dart/input.dart';
import 'package:flutter_poc/repeatwidgets.dart/reaptscreen.dart';
import 'package:flutter_poc/utils/constantData.dart';
import 'package:flutter_poc/webviewpage.dart/webviewscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
              companyLogo("",150,150),
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
              color:themeColorRedBrown,
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebViewPage("Facebook", "https://www.facebook.com")),
                );
                },
              child: Text('Web View',
              
              ),
            ),
            RaisedButton(
              color:themeColorRedBrown,
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RepeatWidget()),
                );
                },
              child: Text('ADD DELETE REPEAT',
              
              ),
            ),
            RaisedButton(
              color:themeColorRedBrown,
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckBoxUI()),
                );
                },
              child: Text('Checkbox Demo',
              
              ),
            ),
            RaisedButton(
              color:themeColorRedBrown,
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyFormUI()),
                );
                },
              child: Text('Form UI Demo',
              
              ),
            ),
            // Container(
            //   height: 100,
            //   width: 400,
            //   child: PasswordWidget(emailRegex)),
            ],
      ),
    );
  }
}
