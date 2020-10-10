import 'package:flutter/material.dart';
import 'package:flutter_poc/CSS/Colors.dart';

Widget gridUI(int count) {
  return GridView.count(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 5,
    children: new List<Widget>.generate(count, (index) {
      return Card(
        elevation: 2.5,
        color: themeColorBlue,
        child: Container(
          child: new Center(
            child: new Text(
              '${index + 1}',
              style: TextStyle(
                color: whiteColor,
              ),
            ),
          ),
        ),
      );
    }),
  );
}
