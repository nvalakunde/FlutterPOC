import 'package:flutter_poc/responsivescreen/responsive.dart';
import 'package:flutter/material.dart';

double defaultScreenWidth = 400.0;
double defaultScreenHeight = 810.0;

TextStyle txtStyle(double size, var colorValue, {var fontWeight}) {
  var scaleWidth =0.0;
  if(screenWidth>400)
     scaleWidth=screenWidth / defaultScreenWidth;
  else
   scaleWidth=screenWidth/(screenWidth*0.9);
  if (fontWeight!= null) {
    return TextStyle(
      inherit: true,
      fontSize: (size * scaleWidth) / textScaleFactors,
      fontFamily: "Roboto",
      color: colorValue,
      fontWeight: fontWeight,
    );
  }
  else{
    return TextStyle(
      inherit: true,
      fontSize: (size * scaleWidth) / textScaleFactors,
      fontFamily: "Roboto",
      color: colorValue,
    );
  }
}