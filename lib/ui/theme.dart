import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);

//0xFF4e5ae8
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color withe = Colors.white;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = const Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.cairo(
      textStyle:  TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode?Colors.grey[400]:Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.cairo(
      textStyle:  TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color:Get.isDarkMode?Colors.white:Colors.black,
  ));
}
TextStyle get titleStyle {
  return GoogleFonts.cairo(
      textStyle:  TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color:Get.isDarkMode?Colors.white:Colors.black,
  ));
}TextStyle get sunTileStyle {
  return GoogleFonts.cairo(
      textStyle:  TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color:Get.isDarkMode?Colors.grey[100]:Colors.grey[600],
  ));
}