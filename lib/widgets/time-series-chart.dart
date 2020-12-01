import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/config/config.dart';

class TimeSeriesRangeAnnotationChart extends StatelessWidget {
  TimeSeriesRangeAnnotationChart(this.seriesList, {this.animate = true, this.label});

  final String label;
  final List<charts.Series> seriesList;
  final bool animate;

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // ignore: sort_constructors_first
  factory TimeSeriesRangeAnnotationChart.withSampleData(String label) {
    return TimeSeriesRangeAnnotationChart(
      _createSampleData(),
      // Disable animations for image tests.
      label: label,
      animate: true,
    );
  }

  factory TimeSeriesRangeAnnotationChart.withData(String label, List<TimeSeriesModel> data) {
    return TimeSeriesRangeAnnotationChart(
      _prepareData(data),
      // Disable animations for image tests.
      label: label,
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Palette.colorWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: Styles.boxShadow),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                Text(label),
                Container(
                  height: 250.0,
                  child: charts.TimeSeriesChart(seriesList, animate: animate),
                )
              ],
            )));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesModel, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesModel(DateTime(2017, 9, 19), 4),
      TimeSeriesModel(DateTime(2017, 9, 26), 1),
      TimeSeriesModel(DateTime(2017, 10, 3), 2),
      TimeSeriesModel(DateTime(2017, 10, 10), 0),
    ];

    return [
      charts.Series<TimeSeriesModel, DateTime>(
        id: 'Sales',
        domainFn: (TimeSeriesModel sales, _) => sales.time,
        measureFn: (TimeSeriesModel sales, _) => sales.value,
        data: data,
      )
    ];
  }

  static List<charts.Series<TimeSeriesModel, DateTime>> _prepareData(List<TimeSeriesModel> data) {


    return [
      charts.Series<TimeSeriesModel, DateTime>(
        id: 'Sales',
        domainFn: (TimeSeriesModel sales, _) => sales.time,
        measureFn: (TimeSeriesModel sales, _) => sales.value,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesModel {
  TimeSeriesModel(this.time, this.value);

  final DateTime time;
  final int value;
}
