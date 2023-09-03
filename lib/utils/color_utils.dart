import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = hexStringToColor('#4A43EC');
  static Color secondaryColor = Color(0xFFE57373);
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

