import 'package:flutter/material.dart';
import 'package:flutter_app/common/page-transitions.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/screens/screens.dart';
import 'package:flutter_app/widgets/button.dart';

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
                      TimeSeriesRangeAnnotationChart.withSampleData('Donated'),
                      SizedBox(
                        height: 16.0,
                      ),
                      TimeSeriesRangeAnnotationChart.withSampleData('Received'),
                      SizedBox(
                        height: 16.0,
                      ),
                      Button(
                        text: 'VIEW ALL REQUESTS',
                        onPressed: () {_navigateTo(context, ListScreen(title: 'ALL REQUESTS HISTORY'));},
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Button(
                        text: 'VIEW ALL DONATIONS',
                        onPressed: () {_navigateTo(context, ListScreen(title: 'ALL DONATIONS HISTORY'));},
                      ),
                    ],
                  )),
        ));
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(EnterExitRoute(exitPage: this, enterPage: screen));
  }
}
