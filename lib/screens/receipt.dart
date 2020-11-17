import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/outlined-details-list.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen(
      {Key key,
      this.requestorName = 'Sarah Khan',
      this.requestorEmail = 'sarah@gmail.com',
      this.requestorContact = '+92 333 1231231',
      this.donorName = 'Arbaz Jahanzeb',
      this.donorEmail = 'arbaz@gmail.com',
      this.donorContact = '+92 333 7867867',
      this.bloodType = 'O -ve',
      this.numberOfBottles = '2'})
      : super(key: key);

  final String requestorName;
  final String requestorEmail;
  final String requestorContact;

  final String donorName;
  final String donorEmail;
  final String donorContact;

  final String bloodType;
  final String numberOfBottles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('RECEIPT'.toUpperCase(), style: TextStyle(fontSize: 18.0))),
        body: Builder(
          builder: (scaffoldContext) => Container(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  ListView(
                      physics: ClampingScrollPhysics(),

                        children: [
                          OutlinedDetailsList(label: "Requestor's Details", data: {
                            'Name': requestorName,
                            'Email': requestorEmail,
                            'Contact Number': requestorContact
                          }),
                          SizedBox(
                            height: 16.0,
                          ),
                          OutlinedDetailsList(label: "Donor's Details", data: {
                            'Name': donorName,
                            'Email': donorEmail,
                            'Contact Number': donorContact
                          }),
                          SizedBox(
                            height: 16.0,
                          ),
                          OutlinedDetailsList(label: 'Blood Details', data: {
                            'Blood Type': bloodType,
                            'Number of Bottles': numberOfBottles,
                          }),
                          SizedBox(
                            height: 32.0 + 96.0,
                          ),
                        ],
                      ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          text: 'SAVE',
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Button(
                          text: 'CONFIRM',
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
