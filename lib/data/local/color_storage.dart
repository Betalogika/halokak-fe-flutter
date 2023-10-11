import 'dart:ui';

import 'package:flutter/material.dart';

class ColorStorage {
  static const bgDefault = Color(0xffF8F7F3);
  static const blue = Color(0xff6AC8D2);
  static const orange = Color(0xffFEC395);
  static const red = Color(0xffD00A0A);
  static const gray = Color(0xff53565A);
  static const black = Color(0xff444444);
  static const border = Color(0xFFE4E4E4);
  static const disabled = Color.fromARGB(255, 230, 228, 228);
  static MaterialColor mcBlue = MaterialColor(blue.value, colorShades);
}

Map<int, Color> colorShades =
{
  50:const Color.fromRGBO(136,14,79, .1),
  100:const Color.fromRGBO(136,14,79, .2),
  200:const Color.fromRGBO(136,14,79, .3),
  300:const Color.fromRGBO(136,14,79, .4),
  400:const Color.fromRGBO(136,14,79, .5),
  500:const Color.fromRGBO(136,14,79, .6),
  600:const Color.fromRGBO(136,14,79, .7),
  700:const Color.fromRGBO(136,14,79, .8),
  800:const Color.fromRGBO(136,14,79, .9),
  900:const Color.fromRGBO(136,14,79, 1),
};