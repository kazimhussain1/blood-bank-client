import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/config/palette.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/CustomTextField.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('SIGN IN'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _textEditingController.clear();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          child: Builder(
            builder: (BuildContext scaffoldContext) => Container(
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(scaffoldContext).appBarMaxHeight,
              padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Palette.colorPrimary,
                                  shape: BoxShape.circle,
                                  boxShadow: Styles.boxShadow,
                                ),
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 48.0,
                                  color: Palette.colorOnPrimary,
                                )),
                            SizedBox(
                              height: 32.0,
                            ),
                            Text('WELCOME!', style: Styles.largePrimaryBoldText),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text('Sign in to continue', style: Styles.mediumAccentText)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Palette.colorWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                        boxShadow: Styles.boxShadow,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            CustomTextField(
                                label: 'Email',
                                controller: emailController,
                              ),
                            SizedBox(
                              height: 12.0,
                            ),
                            CustomTextField(
                              label: 'Password',
                              isPassword: true,
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 44.0,
                            ),
                            Builder(
                              builder: (BuildContext context) => Button(
                                width: 200.0,
                                text: 'SIGN IN',
                                onPressed: () {

                                  _signIn(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  child: Text('Sign Up'),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(_navigateTo(SignUpScreen())),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(BuildContext context) async {
//    Navigator.of(context).popUntil((route) => route.isFirst);
//    await Navigator.of(context).pushReplacement(_navigateTo(RequestBloodScreen()));
    // set up POST request arguments
    var url = 'http://10.0.2.2/blood-bank/public/api/login';

    var map = <String, dynamic>{};

    map['email'] = emailController.text;
    map['password'] = passwordController.text;
    map['confirm_password'] = passwordController.text;
    // make POST request
    var response = await post(url, body: map);
    // check the status code for the result
    var statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    // body: Map<String, dynamic>
    var body = jsonDecode(response.body);

    if (statusCode == 200) {
      Navigator.of(context).popUntil((route) => route.isFirst);

      var prefs = await SharedPreferences.getInstance();
      print(body['token']);
      await prefs.setString('token', body['success']['token']);

      await Navigator.of(context).pushReplacement(_navigateTo(HomeScreen()));
    } else {

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Oops something went wrong'),
      ));
    }
  }

  Route _navigateTo(Widget screen) {
    return EnterExitRoute(exitPage: this, enterPage: screen);
  }
}
