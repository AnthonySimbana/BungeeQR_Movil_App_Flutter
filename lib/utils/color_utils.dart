import 'package:flutter/material.dart';

class AppColors {
  //Colores primarios y secundarios de la aplicacion
  static Color primaryColor = hexStringToColor('#4A43EC');
  static Color secondaryColor = Color(0xFFE57373);

  Color getPrimaryColor() {
    return primaryColor;
  }
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
