import 'package:flutter/material.dart';
import 'package:flutter_app/screens/screens.dart';
import 'config/palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          primaryColor: Palette.colorPrimary,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Palette.colorPrimary),
                  overlayColor:
                      MaterialStateProperty.all(Palette.colorPrimary.withAlpha(25))))),
      home: GettingStartedScreen(),
    );
  }
}
