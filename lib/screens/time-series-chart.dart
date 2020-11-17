import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/config/config.dart';

class TimeSeriesRangeAnnotationChart extends StatelessWidget {
  TimeSeriesRangeAnnotationChart(this.seriesList, {this.animate, this.label});

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
      animate: false,
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
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), 4),
      TimeSeriesSales(DateTime(2017, 9, 26), 1),
      TimeSeriesSales(DateTime(2017, 10, 3), 2),
      TimeSeriesSales(DateTime(2017, 10, 10), 0),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  TimeSeriesSales(this.time, this.sales);

  final DateTime time;
  final int sales;
}
