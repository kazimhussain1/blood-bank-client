import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    return Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}