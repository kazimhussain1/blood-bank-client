import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/models/blood-request.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/receipt.dart';
import 'package:flutter_app/widgets/outlined-details-list.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class DonateBloodScreen extends StatefulWidget {
  const DonateBloodScreen(this.requestModel, {Key key}) : super(key: key);

  @override
  _DonateBloodScreenState createState() => _DonateBloodScreenState();

  final BloodRequestModel requestModel;

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
  void initState() {
    // TODO: implement initState
    super.initState();

    nameController.text = HomeScreen.user.name;
    emailController.text = HomeScreen.user.email;
  }

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
                            'Name': widget.requestModel.user.name,
                            'Email': widget.requestModel.user.email,
                            'Phone': widget.requestModel.contactNumber,
                            'Blood Type': widget.requestModel.bloodType,
                            'Bottles': widget.requestModel.numOfBottles.toString(),
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          label: 'Name',
                          controller: nameController,
                          disabled: true,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        CustomTextField(
                          label: 'Email',
                          controller: emailController,
                          disabled: true,
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
                          data: [widget.requestModel.bloodType],
                          fixedValue: widget.requestModel.bloodType,
                          onSelect: (value) {
                            bloodType = value;
                          },
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        DropDownButton<int>(
                          label: 'Number of bottles',
                          data: List<int>.generate(
                              widget.requestModel.numOfBottles, (i) => i + 1),
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
                            _makeDonation(scaffoldContext);
                          },
                        )
                      ],
                    ),
                  )))),
    );
  }

  void _makeDonation(BuildContext scaffoldContext) async {
    if (phoneController.text.isEmpty) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Contact Number is required'),
      ));
      return;
    }
    if (numOfBottles == null) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Please select Number of Bottles'),
      ));
      return;
    }

    var url = '${NetworkUtility.BASE_URL}blood/donation';

    var map = <String, dynamic>{};

    map['user_id'] = HomeScreen.user.id.toString();
    map['blood_request_id'] = widget.requestModel.id.toString();
    map['contact_number'] = phoneController.text;
    map['num_of_bottles'] = numOfBottles.toString();

    // make POST request
    var response = await http.post(url, headers: NetworkUtility.generateHeader(), body: map);
    // check the status code for the result
    var statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    var body = jsonDecode(response.body);

    if (statusCode == 200) {
//      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
//        backgroundColor: Colors.green,
//        content: Text('Request Successful'),
//      ));

      BloodDonationModel.fromJson(body['success']['donation']);

      await Navigator.of(context)
          .push(widget.navigateTo(
              ReceiptScreen(BloodDonationModel.fromJson(body['success']['donation']))))
          .then((value) => Navigator.pop(context));
    } else {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Oops something went wrong'),
      ));
    }
  }
}
