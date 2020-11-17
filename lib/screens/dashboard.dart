import 'package:flutter/material.dart';
import 'package:flutter_app/config/config.dart';
import 'package:flutter_app/widgets/button.dart';

import 'time-series-chart.dart';

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
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Button(
                        text: 'VIEW ALL DONATIONS',
                        onPressed: () {},
                      ),
                    ],
                  )),
        ));
  }
}
