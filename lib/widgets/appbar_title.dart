import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
            text: 'Quiz',
            style:
                TextStyle(fontWeight: FontWeight.w800, color: Colors.black54)),
        TextSpan(
            text: 'Maker',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
      ],
    ),
  );
}
