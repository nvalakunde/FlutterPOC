import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/carosal/formui.dart';
import 'package:flutter_poc/cascadedropdown/cascadmodel.dart';
import 'package:flutter_poc/repository/repository.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

class ResponsiveScreenUI extends StatefulWidget {
  @override
  _ResponsiveScreenUIState createState() => _ResponsiveScreenUIState();
}

class _ResponsiveScreenUIState extends State<ResponsiveScreenUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: setHeight(20),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: setHeight(50),
                      margin: EdgeInsets.all(setHeight(16)),
                      child: Center(
                        child: Text(
                          "Samsung",
                          style: txtStyle(15, Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        addToCart['Samsung'] != null && addToCart['Samsung']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: setHeight(44),
                        color:
                            addToCart['Samsung'] != null && addToCart['Samsung']
                                ? Colors.red
                                : Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          if (addToCart['Samsung'] != null &&
                              addToCart['Samsung']) {
                            addToCart['Samsung'] = false;
                          } else {
                            addToCart['Samsung'] = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: setHeight(50),
                      margin: EdgeInsets.all(setHeight(16)),
                      child: Center(
                        child: Text(
                          "LG",
                          style: txtStyle(15, Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        addToCart['LG'] != null && addToCart['LG']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: setHeight(44),
                        color: addToCart['LG'] != null && addToCart['LG']
                            ? Colors.red
                            : Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          if (addToCart['LG'] != null && addToCart['LG']) {
                            addToCart['LG'] = false;
                          } else {
                            addToCart['LG'] = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: setHeight(50),
                      margin: EdgeInsets.all(setHeight(16)),
                      child: Center(
                        child: Text(
                          "SONY",
                          style: txtStyle(15, Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        addToCart['SONY'] != null && addToCart['SONY']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: setHeight(44),
                        color: addToCart['SONY'] != null && addToCart['SONY']
                            ? Colors.red
                            : Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          if (addToCart['SONY'] != null && addToCart['SONY']) {
                            addToCart['SONY'] = false;
                          } else {
                            addToCart['SONY'] = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: setHeight(20),
              ),
              Text(
                "Responsive Text",
                style: txtStyle(15, Colors.black),
              ),
              IconButton(
                  icon: Icon(
                    Icons.today,
                    size: setHeight(44),
                  ),
                  onPressed: null),
              Container(
                margin: EdgeInsets.all(setHeight(10)),
                child: Image.network(
                  "https://via.placeholder.com/1500",
                  height: 100,
                  width: 100,
                ),
              ),
              Container(
                margin: EdgeInsets.all(setHeight(10)),
                child: Image.network(
                  "https://via.placeholder.com/1500",
                  height: setHeight(100),
                  width: setWidth(100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
