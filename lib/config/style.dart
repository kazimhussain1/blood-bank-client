import 'package:flutter/material.dart';
import 'palette.dart';

class Styles {
  static const TextStyle largePrimaryText =
      TextStyle(fontSize: 26.0, color: Palette.colorPrimary);

  static const TextStyle largePrimaryBoldText =
      TextStyle(fontSize: 26.0, color: Palette.colorPrimary, fontWeight: FontWeight.w600);

  static const TextStyle mediumPrimaryBoldText =
      TextStyle(fontSize: 18.0, color: Palette.colorPrimary, fontWeight: FontWeight.w600);

  static const TextStyle mediumAccentText =
      TextStyle(fontSize: 18.0, color: Palette.colorAccent, fontWeight: FontWeight.w600);

  static var boxShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    )
  ];
}
