import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';

class OutlinedContainer extends StatelessWidget {

  const OutlinedContainer({Key key, this.label, this.child, this.padding}) : super(key: key);

  final String label;
  final Widget child;
  final EdgeInsetsGeometry padding;



  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 9.0),
        child: Container(
          padding: padding,
          width: double.infinity,
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.5),
            child: child,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          label != null ? ' $label ' : '',
          style: TextStyle(
              fontSize: 16.0, backgroundColor: Palette.colorWhite, color: Colors.grey[700]),
        ),
      )
    ]);
  }
}
