import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart_app/presentation/samples/chart_samples.dart';
import 'package:fl_chart_app/presentation/samples/line/line_chart_sample2.dart';
import 'package:fl_chart_app/presentation/widgets/chart_holder.dart';
import 'package:fl_chart_app/util/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ChartSamplesPage extends StatelessWidget {
  final ChartType chartType;

  final samples = ChartSamples.samples;

  ChartSamplesPage({
    Key? key,
    required this.chartType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LineChartSample2()

    );
  }
}
