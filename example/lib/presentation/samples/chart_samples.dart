import 'package:fl_chart_app/presentation/samples/chart_sample.dart';
import 'package:fl_chart_app/presentation/samples/line/line_chart_sample2.dart';
import 'package:fl_chart_app/util/app_helper.dart';

class ChartSamples {
  static final Map<ChartType, List<ChartSample>> samples = {
    ChartType.line: [
      LineChartSample(2, (context) => const LineChartSample2()),
    ],
    ChartType.bar: [

    ],
    ChartType.pie: [

    ],
    ChartType.scatter: [
    ],
    ChartType.radar: [
    ],
  };
}
