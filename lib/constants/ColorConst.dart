import 'package:flutter/material.dart';

var primaryColor = Colors.yellow[900];
var activeColor = const Color(0XFF26282B);

Widget CustomText(val, siz, col, FontWeight wei) {
  return Text(
    val,
    style: TextStyle(color: col, fontSize: siz, fontWeight: wei),
  );
}
