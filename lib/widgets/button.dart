import 'dart:ffi';

import 'package:flutter/material.dart';
import '../config/palette.dart';

class Button extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  final Function onPressed;

  const Button(
      {Key key,
      this.width = double.infinity,
      this.backgroundColor = Palette.colorPrimary,
      this.foregroundColor = Palette.colorOnPrimary,
      this.text,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          text,
          style: TextStyle(color: foregroundColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
