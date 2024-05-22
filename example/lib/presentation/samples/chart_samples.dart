import 'package:fl_chart_app/util/app_helper.dart';

import 'bar/bar_chart_sample1.dart';
import 'bar/bar_chart_sample2.dart';
import 'bar/bar_chart_sample3.dart';
import 'bar/bar_chart_sample4.dart';
import 'bar/bar_chart_sample5.dart';
import 'bar/bar_chart_sample6.dart';
import 'bar/bar_chart_sample7.dart';
import 'bar/bar_chart_sample8.dart';
import 'chart_sample.dart';
import 'pie/pie_chart_sample1.dart';
import 'pie/pie_chart_sample2.dart';
import 'pie/pie_chart_sample3.dart';
import 'radar/radar_chart_sample1.dart';

class ChartSamples {
  static final Map<ChartType, List<ChartSample>> samples = {
    ChartType.line: [

    ],
    ChartType.bar: [
      BarChartSample(1, (context) => BarChartSample1()),
      BarChartSample(2, (context) => BarChartSample2()),
      BarChartSample(3, (context) => const BarChartSample3()),
      BarChartSample(4, (context) => BarChartSample4()),
      BarChartSample(5, (context) => const BarChartSample5()),
      BarChartSample(6, (context) => const BarChartSample6()),
      BarChartSample(7, (context) => BarChartSample7()),
      BarChartSample(8, (context) => BarChartSample8()),
    ],
    ChartType.pie: [
      PieChartSample(1, (context) => const PieChartSample1()),
      PieChartSample(2, (context) => const PieChartSample2()),
      PieChartSample(3, (context) => const PieChartSample3()),
    ],
    ChartType.scatter: [
    ],
    ChartType.radar: [
      RadarChartSample(1, (context) => RadarChartSample1()),
    ],
  };
}
