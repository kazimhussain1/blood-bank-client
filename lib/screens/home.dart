import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/models/models.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const slides = [
    {'image': 'assets/images/p1.png', 'text': 'Give Blood, Save Lives'},
    {'image': 'assets/images/p2.png', 'text': 'People Live When People Give'},
    {'image': 'assets/images/p3.png', 'text': 'Keep Calm And Donate Blood'},
    {'image': 'assets/images/p4.png', 'text': 'Donate Blood Give A Smile to Someone'},
  ];

  static const required = [
    {'name': 'John Doe', 'bloodType': 'O +ve'},
    {'name': 'Jane Smith', 'bloodType': 'A +ve'},
    {'name': 'Bruce Wayne', 'bloodType': 'B +ve'},
    {'name': 'John Doe', 'bloodType': 'O -ve'},
    {'name': 'John Doe', 'bloodType': 'AB -ve'},
    {'name': 'John Doe', 'bloodType': 'B -ve'},
    {'name': 'John Doe', 'bloodType': 'O -ve'},
    {'name': 'John Doe', 'bloodType': 'A +ve'},
  ];

  static String token;
  static UserModel user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<BloodRequestModel> activeRequests = [];

  @override
  void initState() {
    super.initState();

    initData();
  }

  Future<void> getSavedData() async {
    var prefs = await SharedPreferences.getInstance();
    HomeScreen.token = await prefs.getString('token');
    HomeScreen.user = UserModel.fromJson(jsonDecode(await prefs.getString('user')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true, title: Text('BLOOD BANK', style: TextStyle(fontSize: 18.0))),
        drawer: _navigationDrawer(context),
        body: Builder(
            builder: (scaffoldContext) => Container(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 300.0,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                        ),
                        items: HomeScreen.slides.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                        boxShadow: Styles.boxShadow,
                                        borderRadius: BorderRadius.circular(8.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(item['image']),
                                    ),
                                  ),
                                  Text(
                                    item['text'],
                                    style: Styles.mediumAccentText,
                                  )
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Text(
                        'New Requests',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Palette.colorPrimary,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: activeRequests.isEmpty
                            ? Center(
                                child: Text('No active requests',
                                    style: TextStyle(fontSize: 14, color: Palette.colorGrey)),
                              )
                            : ListView.builder(
                                itemCount: activeRequests.length,
                                itemBuilder: (buildContext, index) => Container(
                                      padding: EdgeInsets.all(16.0),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                          color: Palette.colorWhite,
                                          boxShadow: Styles.boxShadow,
                                          borderRadius: BorderRadius.circular(8.0)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            _navigateTo(context,
                                                DonateBloodScreen(activeRequests[index]));
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(activeRequests[index].user.name,
                                                  style: TextStyle(
                                                      color: Palette.colorPrimaryLight,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w500)),
                                              Text(activeRequests[index].bloodType,
                                                  style: TextStyle(
                                                      color: Palette.colorPrimary,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w500))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                      )
                    ],
                  ),
                )));
  }

  Builder _navigationDrawer(BuildContext context) {
    return Builder(
      builder: (scaffoldContext) => Drawer(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200.0,
                color: Palette.colorPrimary,
              ),
              FlatButton(
                  onPressed: () {
                    if (_scaffoldKey.currentState.isDrawerOpen) {
                      _scaffoldKey.currentState.openEndDrawer();
                    }

                    _navigateTo(scaffoldContext, DashboardScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Dashboard',
                            style: TextStyle(color: Palette.colorPrimary, fontSize: 20.0))),
                  )),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
//              FlatButton(
//                  onPressed: () {
//                    if (_scaffoldKey.currentState.isDrawerOpen) {
//                      _scaffoldKey.currentState.openEndDrawer();
//                    }
//
//                    _navigateTo(scaffoldContext, DonateBloodScreen());
//                  },
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 16.0),
//                    child: Align(
//                        alignment: Alignment.centerLeft,
//                        child: Text('Donate Blood',
//                            style: TextStyle(color: Palette.colorPrimary, fontSize: 20.0))),
//                  )),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              FlatButton(
                  onPressed: () {
                    if (_scaffoldKey.currentState.isDrawerOpen) {
                      _scaffoldKey.currentState.openEndDrawer();
                    }

                    _navigateTo(scaffoldContext, RequestBloodScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Request Blood',
                            style: TextStyle(color: Palette.colorPrimary, fontSize: 20.0))),
                  )),
              Container(
                height: 1.0,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FlatButton(
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        await prefs.setString('token', null);
                        await Navigator.of(context).pushReplacement(EnterExitRoute(
                            exitPage: widget, enterPage: GettingStartedScreen()));
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Palette.colorPrimary,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text('Logout',
                                  style:
                                      TextStyle(color: Palette.colorPrimary, fontSize: 20.0)),
                            ],
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<BloodRequestModel>> initData() async {
    await getSavedData();
    var url = NetworkUtility.BASE_URL + 'blood/request/active';


    var response = await http.get(url, headers: {
      'Authorization': 'Bearer ${HomeScreen.token}',
      'Content-Type': 'application/json'
    });
    var body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        activeRequests = body['success']
            .map<BloodRequestModel>((item) => BloodRequestModel.fromJson(item))
            .toList();
      });
    }
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(EnterExitRoute(exitPage: widget, enterPage: screen)).then((value){
      initData();
    });
  }
}
