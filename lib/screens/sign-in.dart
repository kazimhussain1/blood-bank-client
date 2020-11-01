import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.js.dart';
import 'package:flutter_app/config/palette.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/CustomTextField.dart';
import 'package:flutter_app/widgets/button.dart';

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
        title: Text("SIGN IN"),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 48.0,
                                  color: Palette.colorOnPrimary,
                                )),
                            SizedBox(
                              height: 32.0,
                            ),
                            Text("WELCOME!", style: Styles.largePrimaryBoldText),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text("Sign in to continue", style: Styles.mediumAccentText)
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Focus(
                              onFocusChange: (focused) {
//                              if(focused)
//                                scrollController.animateTo(0.0,
//                                    duration: Duration(milliseconds: 500), curve: Curves.ease);
//
//                              print("clicked");
                              },
                              child: CustomTextField(
                                label: "Email",
                                controller: emailController,
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            CustomTextField(
                              label: "Password",
                              isPassword: true,
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 44.0,
                            ),
                            Button(
                              width: 200.0,
                              text: "SIGN IN",
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _textEditingController.clear();

                                print(emailController.text + " " + passwordController.text);
                              },
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  child: Text("Sign Up"),
                                  onPressed: () =>
                                      Navigator.of(context).pushReplacement(_navigateTo(SignUpScreen())),
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

  Route _navigateTo(Widget screen) {
    return EnterExitRoute(exitPage: this, enterPage: screen);
  }
}
