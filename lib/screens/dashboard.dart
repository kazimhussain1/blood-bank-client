import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:http/http.dart' as http;

import '../widgets/time-series-chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true, title: Text('DASHBOARD', style: TextStyle(fontSize: 18.0))),
        body: Container(
          child: Builder(
              builder: (scaffoldContext) => ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(16.0),
                    children: [
                      FutureBuilder(
                          future: _getData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<TimeSeriesModel> donations = snapshot.data['blood_donations']
                                  .map<TimeSeriesModel>((item) => TimeSeriesModel(
                                      DateTime.parse(item['created_at']),
                                      item['num_of_bottles']))
                                  .toList();
                              List<TimeSeriesModel> requests = snapshot.data['blood_requests']
                                  .map<TimeSeriesModel>((item) => TimeSeriesModel(
                                      DateTime.parse(item['created_at']),
                                      item['num_of_bottles']))
                                  .toList();
                              print(donations[0].time);
                              return Column(
                                children: [
                                  TimeSeriesRangeAnnotationChart.withData('Donated', donations),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  TimeSeriesRangeAnnotationChart.withData('Received', requests),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Button(
                                    text: 'VIEW ALL REQUESTS',
                                    onPressed: () {
                                      _navigateTo(
                                          context,
                                          ListScreen('ALL REQUESTS HISTORY',
                                              snapshot.data['blood_requests'], request: true));
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Button(
                                    text: 'VIEW ALL DONATIONS',
                                    onPressed: () {
                                      _navigateTo(
                                          context,
                                          ListScreen('ALL DONATIONS HISTORY',
                                              snapshot.data['blood_donations']));
                                    },
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              Container(
                                  height: 400,
                                  child: Center(
                                      child: Text('An error occured while fetching the data')));
                            }

                            return Container(
                                height: 400, child: Center(child: CircularProgressIndicator()));
                          }),
                    ],
                  )),
        ));
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(EnterExitRoute(exitPage: this, enterPage: screen));
  }

  Future<Map<String, dynamic>> _getData() async {
    var url = '${NetworkUtility.BASE_URL}details';

    var response = await http.get(url, headers: NetworkUtility.generateHeader());

    var body = jsonDecode(response.body)['success'];

    if (response.statusCode == 200) {
      return body;
    } else {
      throw Exception();
    }
  }
}
