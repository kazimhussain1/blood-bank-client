import 'package:flutter/material.dart';
import '../config/palette.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController = TextEditingController();

  final String label;
  final bool isPassword;
  final TextEditingController controller;

  CustomTextField(
      {Key key, @required this.label, this.isPassword = false, this.controller})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? !_showPassword : false,
      focusNode: focusNode,
      decoration: new InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  !_showPassword ? Icons.visibility : Icons.visibility_off,
                  size: 24.0,
                ),
                onPressed: () => setState(() {
                  _showPassword = !_showPassword;
                  if (!focusNode.hasFocus) {
                    focusNode.unfocus();
                    focusNode.canRequestFocus = false;

                    //Enable the text field's focus node request after some delay
                    Future.delayed(Duration(milliseconds: 100), () {
                      focusNode.canRequestFocus = true;
                    });
                  }
                }),
              )
            : null,
        labelText: widget.label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.colorPrimary, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
    );
  }
}
