import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.js.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('SIGN UP'),
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
                                  Icons.account_circle_outlined,
                                  size: 48.0,
                                  color: Palette.colorOnPrimary,
                                )),
                            SizedBox(
                              height: 32.0,
                            ),
                            Text('CREATE NEW ACCOUNT', style: Styles.largePrimaryBoldText),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text('Sign up to start your\njourney',
                                textAlign: TextAlign.center, style: Styles.mediumAccentText)
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
                              height: 16,
                            ),
                            CustomTextField(
                              label: 'Full Name',
                              controller: nameController,
                            ),
                            SizedBox(
                              height: 12.0,
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
                              height: 36.0,
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                return Button(
                                  width: 200.0,
                                  text: 'SIGN UP',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    _textEditingController.clear();

                                    _signUp(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already have an account?'),
                                TextButton(
                                  child: Text('Sign In'),
                                  onPressed: () => {
                                    Navigator.of(context)
                                        .pushReplacement(_navigateTo(SignInScreen())),
                                  },
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

  void _signUp(BuildContext context) async {
    // set up POST request arguments
    var url = 'http://10.0.2.2/blood-bank/public/api/register';

    var map = <String, dynamic>{};

    map['name'] = nameController.text;
    map['email'] = emailController.text;
    map['password'] = passwordController.text;
    map['confirm_password'] = passwordController.text;
    // make POST request
    var response = await post(url, body: map);
    // check the status code for the result
    var statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    var body = response.body;

    if (statusCode == 200) {
      await Navigator.of(context).pushReplacement(_navigateTo(SignInScreen()));
    } else {
      print(statusCode);
      print(body);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Oops something went wrong'),
      ));
    }
  }

  Route _navigateTo(Widget screen) {
    return EnterExitRoute(exitPage: this, enterPage: screen);
  }
}
