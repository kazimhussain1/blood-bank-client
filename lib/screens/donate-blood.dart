import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/screens/receipt.dart';
import 'package:flutter_app/widgets/outlined-details-list.dart';
import 'package:flutter_app/widgets/widgets.dart';

class DonateBloodScreen extends StatefulWidget {
  @override
  _DonateBloodScreenState createState() => _DonateBloodScreenState();

  Route navigateTo(Widget screen) {
    return EnterExitRoute(exitPage: this, enterPage: screen);
  }
}

class _DonateBloodScreenState extends State<DonateBloodScreen> {
  String bloodType;

  int numOfBottles;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('DONATE BLOOD'.toUpperCase(), style: TextStyle(fontSize: 18.0))),
      body: Builder(
          builder: (scaffoldContext) => Container(
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(scaffoldContext).appBarMaxHeight,
              child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        OutlinedDetailsList(
                          label: 'Request Details',
                          data: {
                            'Name': 'Name',
                            'Email': 'Email',
                            'Contact Number': 'Contact Number',
                            'Blood Type': 'Blood Type',
                            'Number of Bottles': 'Number of Bottles',
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          label: 'Name',
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        CustomTextField(
                          label: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        CustomTextField(
                          label: 'Contact Number',
                          controller: phoneController,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        DropDownButton<String>(
                          label: 'Blood Type',
                          data: [
                            'A +ve',
                            'A -ve',
                            'B +ve',
                            'B -ve',
                            'AB +ve',
                            'AB -ve',
                            'O +ve',
                            'O -ve',
                          ],
                          onSelect: (value) {
                            bloodType = value;
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        DropDownButton<int>(
                          label: 'Number of bottles',
                          data: [1, 2, 3, 4, 5],
                          onSelect: (value) {
                            numOfBottles = value;
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Button(
                          text: 'DONATE',
                          onPressed: () {
                            Navigator.of(context).push(widget.navigateTo(ReceiptScreen()));
                          },
                        )
                      ],
                    ),
                  )))),
    );
  }
}
