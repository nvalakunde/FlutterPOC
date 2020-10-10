import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter_poc/settings/passwordreset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingUI extends StatefulWidget {
  @override
  _SettingUIsState createState() => new _SettingUIsState();
}

class _SettingUIsState extends State<SettingUI> {
  bool notifyEnable = false;
  bool autoPlayEnable = false;
  bool autoPlayVideos = false;
  bool notifyMe = false;
  String videoQuality = "720P";
  @override
  void initState() {
    super.initState();
    getSettingUIs();
  }

  getSettingUIs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String autoPlay = prefs.getString("autoplay");
      String notify = prefs.getString("notify");
      if (autoPlay == 'Yes') {
        autoPlayEnable = true;
      }
      if (notify == 'Yes') {
        notifyEnable = true;
      }
      videoQuality = prefs.getString("videoQuality");
    });

    print("In get quality");
  }

  setQuality(String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("videoQuality", newValue);
    setState(() {
      videoQuality = newValue;
    });
    print("In set quality");
  }

  autoPlayVideo(bool playValue) async {
    print("Auto Play Called" + playValue.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (playValue){
      autoPlayVideos=true;
      prefs.setString("autoplay", "Yes"); 
    }
      
    else{
       autoPlayVideos=false;
      prefs.setString("autoplay", "No");
    }
  }

  notifiy(bool noyifyValue) async {
    print("Notify Set Called" + noyifyValue.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (noyifyValue) {
      prefs.setString("notify", "Yes");
      notifyMe = true;
    } else {
      prefs.setString("notify", "No");
      notifyMe = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //drawer: MyDrawer(currentProfilePic),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CatalogCourses()),
              // );
            },
          ),
          title: Text("SettingUIs", style: txtStyle(18, Colors.black)),
          backgroundColor: themebkgColor,
          iconTheme: new IconThemeData(),
        ),
        body: Container(
          // alignment: Alignment.center,
          margin: EdgeInsets.all(setWidth(10)),
          width: screenWidth,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: setFontSize(16),
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    //width: 20,
                    child: Switch(
                      value: notifyEnable,
                      activeColor: themeColorBlue,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.black12,
                      onChanged: (bool value) {
                        setState(() {
                          notifyEnable = value;
                          notifiy(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Auto Play Video",
                    style: TextStyle(
                      fontSize: setFontSize(16),
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    //width: 20,
                    child: Switch(
                      value: autoPlayEnable,
                      activeColor: themeColorBlue,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.black12,
                      onChanged: (bool value) {
                        setState(() {
                          autoPlayEnable = value;
                          autoPlayVideo(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Preffered Video Quality",
                    style: TextStyle(
                      fontSize: setFontSize(16),
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Container(
                    width: setHeight(90),
                    // height: setHeight(30),
                    // color: Colors.black12,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: videoQuality,
                        items: <String>['1080P', '720P', '480P',
                        //  'Auto'
                         ]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              //width: setHeight(50),
                              child: new Text(
                                "       "+value,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          print("videoQuality");
                          print(videoQuality);
                          setState(() {
                            setQuality(newValue);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: setFontSize(16),
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Icon(Icons.keyboard_arrow_right),
                  Container(
                    //width: 20,
                    child: RaisedButton(
                      child: Text("CHANGE", style: txtStyle(12, Colors.white)
                          //TextStyle(color: Colors.white),
                          ),
                      color: Colors.red,
                      onPressed: () {
                         Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => PasswordReset(email: "uid",)));
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text(
              //       "Deactive Account ?",
              //       style: TextStyle(
              //         fontSize: setFontSize(16),
              //         color: Colors.black,
              //       ),
              //       textAlign: TextAlign.left,
              //     ),
              //     Container(
              //       //width: 20,
              //       child: RaisedButton(
              //         child: Text("DEACTIVATE", style: txtStyle(12, Colors.white)
              //             //TextStyle(color: Colors.white),
              //             ),
              //         color: Colors.red,
              //         onPressed: () {
                       
              //         },
              //       ),
              //       // Switch(
              //       //   value: notifyEnable,
              //       //   activeColor: themeColorBlue,
              //       //   onChanged: (bool value) {
              //       //     setState(() {
              //       //       notifyEnable = value;
              //       //     });
              //       //   },
              //       // ),
              //     ),
              //   ],
              // ),
              // Divider(),
            ],
          ),
        ),
    );
  }
}
