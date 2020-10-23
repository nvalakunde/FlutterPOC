import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';
import 'package:flutter_poc/CSS/textcss.dart';
import 'package:flutter_poc/carosal/carosalui.dart';
import 'package:flutter_poc/carosal/responsivescreen.dart';
import 'package:flutter_poc/carosal/sqfdemo.dart';
import 'package:flutter_poc/responsivescreen/responsive.dart';

Map<String, bool> addToCart = {};

class ApplicationForm extends StatefulWidget {
  @override
  _ApplicationFormState createState() => new _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm>
    with SingleTickerProviderStateMixin<ApplicationForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;
  int _moreIndex = 5;
  bool showVerticalMenu = false;

  void onTabTapped(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 5) {
        showVerticalMenu = !showVerticalMenu;
      }
    });
  }

  Widget getPage(int index) {
    if (index == 0) {
      return FormUIOne();
    }
    if (index == 1) {
      return FormUITwo();
    }
    if (index == 2) {
      return FormUIThree();
    }
    if (index == 3) {
      return FormUIFour();
    }
    if (index == 5 && _moreIndex == 6) {
      return FormUISix();
    }
    if (index == 5 && _moreIndex == 7) {
      return FormUISeven();
    }
    if (index == 5 && _moreIndex == 8) {
      return FormUIEight();
    }
    // A fallback, in this case just PageOne
    return Container(
        child: Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            child: Center(
                child: Text(
              "Cart Items",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ))),
        new ListView.builder(
          shrinkWrap: true,
          itemCount: addToCart.length,
          itemBuilder: (BuildContext context, int index) {
            String key = addToCart.keys.elementAt(index);
            return addToCart[key] ? buildCardUI(key) : Container();
          },
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Container(
            margin: EdgeInsets.all(setHeight(4)), child: Text('Segment Demo')),
      ),
      body: Stack(
        children: [
          showVerticalMenu
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: verticalMenu(context),
                )
              : Container(),
          getPage(_currentIndex),
        ],
      ),

      // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        selectedItemColor: themeColorYellow,
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),
            title: Text('Carosal'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            title: Text('SQFLite'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            title: Text('Responsive'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Family'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Cart'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            title: Text(''),
          ),
        ],
      ),
    );
  }

  Widget FormUIOne() {
    return Container(
      child: CarouselSliderDemo(),
    );
  }

  Widget FormUITwo() {
    return SQFLiteDemo();
  }

  Widget FormUIThree() {
    return ResponsiveScreenUI();
  }

  Widget FormUISix() {
    return Center(child: Text("Sixth"));
  }

  Widget FormUISeven() {
    return Center(child: Text("Seven"));
  }

  Widget FormUIEight() {
    return Center(child: Text("Eight"));
  }

  Widget FormUIFour() {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: setHeight(50),
              margin: EdgeInsets.all(setHeight(16)),
              child: Center(
                child: Text(
                  "MICROMAX",
                  style: txtStyle(15, Colors.black),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                addToCart['MICROMAX'] != null && addToCart['MICROMAX']
                    ? Icons.favorite
                    : Icons.favorite_border,
                size: setHeight(44),
                color: addToCart['MICROMAX'] != null && addToCart['MICROMAX']
                    ? Colors.red
                    : Colors.black45,
              ),
              onPressed: () {
                setState(() {
                  if (addToCart['MICROMAX'] != null && addToCart['MICROMAX']) {
                    addToCart['MICROMAX'] = false;
                  } else {
                    addToCart['MICROMAX'] = true;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalMenu(BuildContext context) {
    return new Container(
      width: 40,
      color: themeColorBlue,
      child: Container(
        child: new Column(
          children: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.adjust,
                  color: whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _moreIndex = 6;
                  });
                }),
            new IconButton(
                icon: new Icon(
                  Icons.disc_full,
                  color: whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _moreIndex = 7;
                  });
                }),
            new IconButton(
                icon: new Icon(
                  Icons.scatter_plot,
                  color: whiteColor,
                ),
                onPressed: () {
                  setState(() {
                    _moreIndex = 8;
                  });
                }),
          ],
        ),
      ),
    );
  }

  Widget buildCardUI(String cartValue) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: setHeight(50),
              margin: EdgeInsets.all(setHeight(16)),
              child: Center(
                child: Text(
                  "$cartValue",
                  style: txtStyle(15, Colors.black),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                addToCart[cartValue] != null && addToCart[cartValue]
                    ? Icons.delete
                    : Icons.favorite_border,
                size: setHeight(44),
                color: addToCart[cartValue] != null && addToCart[cartValue]
                    ? Colors.red
                    : Colors.black45,
              ),
              onPressed: () {
                setState(() {
                  if (addToCart[cartValue] != null && addToCart[cartValue]) {
                    addToCart[cartValue] = false;
                  } else {
                    addToCart[cartValue] = true;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
