import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/models/blood-donation.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/outlined-details-list.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ReceiptScreen extends StatelessWidget {
  ReceiptScreen(this.bloodDonationModel,
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

  final BloodDonationModel bloodDonationModel;
  final String requestorName;
  final String requestorEmail;
  final String requestorContact;

  final String donorName;
  final String donorEmail;
  final String donorContact;

  final String bloodType;
  final String numberOfBottles;

  final ScreenshotController screenshotController = ScreenshotController();

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
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          color: Palette.colorWhite,
                          child: Column(children: [
                            OutlinedDetailsList(label: "Requestor's Details", data: {
                              'Name': bloodDonationModel.bloodRequest.user.name,
                              'Email': bloodDonationModel.bloodRequest.user.email,
                              'Phone': bloodDonationModel.bloodRequest.contactNumber
                            }),
                            SizedBox(
                              height: 16.0,
                            ),
                            OutlinedDetailsList(label: "Donor's Details", data: {
                              'Name': bloodDonationModel.user.name,
                              'Email': bloodDonationModel.user.email,
                              'Phone': bloodDonationModel.contactNumber
                            }),
                            SizedBox(
                              height: 16.0,
                            ),
                            OutlinedDetailsList(label: 'Blood Details', data: {
                              'Blood Type': bloodDonationModel.bloodRequest.bloodType,
                              'Bottles': bloodDonationModel.numOfBottles.toString(),
                            }),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 96.0,
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          text: 'SAVE AS SCREENSHOT',
                          onPressed: () async {
                            await _requestPermission();
                            await screenshotController.capture().then((File image) async {
                              print('Capture Done');

                              final result = await ImageGallerySaver.saveImage(
                                  image.readAsBytesSync(),
                                  quality: 95,
                                  name:
                                      'blood_donation_${DateTime.now()}'); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver

                              Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'File Saved to Gallery',
                                  style: TextStyle(
                                      color: Palette.colorWhite, fontWeight: FontWeight.w500),
                                ),
                              ));
                              print('File Saved to Gallery');
                              print(result);
                            }).catchError((onError) {
                              Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
                                content: Text(onError.toString()),
                              ));
                              print(onError);
                            });
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ));
  }

  _requestPermission() async {
    var statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
//    _toastInfo(info);
  }
}
