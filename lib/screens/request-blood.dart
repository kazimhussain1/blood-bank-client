import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class RequestBloodScreen extends StatelessWidget {
  String bloodType;
  int numOfBottles;
  LatLng location;


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  var requestBloodScreenController;
  @override
  Widget build(BuildContext context) {
    nameController.text = HomeScreen.user.name;
    emailController.text = HomeScreen.user.email;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text('REQUEST BLOOD', style: TextStyle(fontSize: 18.0))),
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
                      onSelect: (value) {bloodType = value;},
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    DropDownButton<int>(
                      label: 'Number of bottles',
                      data: [1, 2, 3, 4, 5],
                      onSelect: (value) {numOfBottles = value;},
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    MapWidget(
                      label: 'Choose Location',
                      callback: (latLng) {
                        location = latLng;
                      },
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Button(
                        backgroundColor: Palette.colorPrimary,
                        foregroundColor: Palette.colorWhite,
                        text: 'Submit',
                        onPressed: () => _makeRequest(scaffoldContext))
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _makeRequest(BuildContext scaffoldContext) async {

    if (phoneController.text.isEmpty) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Contact Number is required'),
      ));
      return;
    }
    if (bloodType == null) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Please select Blood Type'),
      ));
      return;
    }
    if (numOfBottles == null) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Please select Number of Bottles'),
      ));
      return;
    }
    if (location == null) {
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Please select Location'),
      ));
      return;
    }

    var url = '${NetworkUtility.BASE_URL}blood/request';

    var map = <String, dynamic>{};


    map['user_id'] = HomeScreen.user.id.toString();
    map['contact_number'] = phoneController.text;
    map['blood_type'] = bloodType;
    map['num_of_bottles'] = numOfBottles.toString();
    map['location'] = '${location.latitude}, ${location.longitude}';
    // make POST request
    var response = await post(url, headers:NetworkUtility.generateHeader(), body: map);
    // check the status code for the result
    var statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    var body = response.body;

    if(statusCode == 200){
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text('Request Successful'),
      ));
      Future.delayed(Duration(seconds: 2),()=>Navigator.pop(scaffoldContext));
    } else{
      print(body);
      Scaffold.of(scaffoldContext).showSnackBar(SnackBar(
        content: Text('Oops something went wrong'),
      ));
    }

  }
}
