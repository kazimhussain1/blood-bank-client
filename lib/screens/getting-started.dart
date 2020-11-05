import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.js.dart';
import 'package:flutter_app/config/palette.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/widgets.dart';

class GettingStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Getting Started'.toUpperCase(), style: TextStyle(fontSize: 18.0))),
      body: Container(
        padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/getting_started.png')),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
                      child: Text(
                        'All Lives Matter.',
                        style: Styles.largePrimaryText,
                      ),
                    ),
                    Text(
                      'A gift straight from \nyour heart.',
                      style: Styles.mediumAccentText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Button(
                text: 'SIGN IN',
                onPressed: () => {
                  Navigator.of(context).push(_navigateTo(SignInScreen())),
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              Button(
                  text: 'SIGN UP',
                  backgroundColor: Palette.colorPrimaryLight,
                  onPressed: () => {
                        Navigator.of(context).push(_navigateTo(SignUpScreen())),
                      }),
              SizedBox(
                height: 32.0,
              ),
              Text(
                'version 1.0',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Route _navigateTo(Widget screen) {
    return EnterExitRoute(exitPage: this, enterPage: screen);
  }
}
