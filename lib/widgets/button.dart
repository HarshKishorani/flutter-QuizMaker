import 'package:flutter/material.dart';

Widget button({BuildContext context, String text, double buttonWidth}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      color: Colors.blue,
    ),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 18),
    width:
        buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width,
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
