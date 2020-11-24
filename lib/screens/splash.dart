import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){

      SharedPreferences.getInstance().then((prefs) async  {
        var token = prefs.getString('token');
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => token != null ? HomeScreen() : GettingStartedScreen()),
        );
      });
    });
    return Scaffold(
      body: Center(
        child: Text('Blood Bank', style: Styles.largePrimaryBoldText),
      ),
    );
  }


}
