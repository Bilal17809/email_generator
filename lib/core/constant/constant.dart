import 'package:flutter/material.dart';
const fontFamily = 'Montserrat';
const double kBodyHp=16;


extension MediaQueryValues on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}






