import 'dart:convert';
import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  List<List<FlSpot<LightHouseTooltip>>> spotData = [];
  bool showAvg = false;

  @override
  void initState() {
    parseJson('assets/metrec1.json', "metric1", Colors.red);
    parseJson('assets/metrec2.json', "metric2", Colors.yellow);
    parseJson('assets/metrec3.json', "metric3", Colors.green);
    parseJson('assets/metrec4.json', "metric4", Colors.blue);
    parseJson('assets/metrec5.json', "metric5", Colors.deepPurple);
    parseJson('assets/metrec6.json', "metric6", Colors.pink);
    // List.generate(20, (index) {
    //   final yRand = Random().nextDouble() * 10;
    //   spotData.add(FlSpot(
    //       index.toDouble(), yRand, LightHouseTooltip(timestamp: 123456708, value: 15, nameMetric: "メモリ使用率", color: const Color(0xff01a7d9), fractionDigit: 1)));
    // });
    super.initState();
  }

  Future<void> parseJson(
      String fileJson, String nameMetric, Color colorMetric) async {
    final metric1 = await rootBundle.loadString(fileJson);
    final serries1Json = json.decode(metric1);
    final list1 = <FlSpot<LightHouseTooltip>>[];
    for (int i = 0; i < serries1Json['timestamps'].length; i++) {
      list1.add(FlSpot(
          serries1Json['timestamps'][i] as double,
          serries1Json["values"][i] as double,
          LightHouseTooltip(
              color: colorMetric,
              nameMetric: nameMetric,
              value: serries1Json["values"][i] as double,
              timestamp: serries1Json["timestamps"][i] * 1000)));
    }
    setState(() {
      spotData.add(list1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 700,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 50,
        ),
        child: Column(
          children: [
            Expanded(
              child: LineChart<LightHouseTooltip>(
                avgData(spotData),
              ),
            ),
            Expanded(
              child: LineChart<LightHouseTooltip>(
                avgData([spotData.first]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData<LightHouseTooltip> avgData(
      List<List<FlSpot<LightHouseTooltip>>> dataChartCustom) {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 35 / 5,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      showingTooltipIndicators: [const ShowingTooltipIndicators([])],
      minX: 1696403435.603,
      maxX: 1696404306.38,
      maxY: 35,
      minY: 0,
      lineTouchData: LineTouchData(
        longPressDuration: const Duration(milliseconds: 50),
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 16,
          tooltipPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          tooltipMargin: 0,
          shadowColor: true
              ? Colors.grey.withOpacity(0.5)
              : const Color.fromARGB(0, 15, 14, 14),
          getTooltipColor: (touchedSpot) => Colors.white,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((e) {
              return LineTooltipItem(
                e.y.toString(),
                isBoolChart: true,
                value: e.data.value.toString(),
                isShowName: dataChartCustom.length > 1,
                customDataChart: e.data,
                textStyleDate: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textStyleHour: const TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textStyleName: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                textStyleValue: TextStyle(
                  color: e.data.color,
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList();
          },
        ),
        getTouchLineEnd: <LightHouseTooltip>(data, index) => double.infinity,
        distanceCalculator: (touchPoint, spotPixelCoordinates) =>
            (touchPoint - spotPixelCoordinates).distance,
        getTouchedSpotIndicator: (barData, spotIndexes) => spotIndexes
            .map((e) => TouchedSpotIndicatorData<LightHouseTooltip>(
                  const FlLine(strokeWidth: 1, color: Colors.black),
                  FlDotData<LightHouseTooltip>(
                    checkToShowDot: (spot, barData) => true,
                    getDotPainter: (spot, xPercentage, bar, index) =>
                        FlDotCirclePainter<LightHouseTooltip>(
                            color: spot.data.color ?? Colors.red, radius: 8),
                  ),
                ))
            .toList(),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
            bottom: BorderSide(width: 2, color: Colors.red),
            top: BorderSide(width: 1, color: Colors.yellow)),
      ),
      titlesData: FlTitlesData(
          show: true,
          leftTitles: getLeftTitles(),
          bottomTitles: getBottomTitles()),
      lineBarsData: getLineBarsData(dataChartCustom),
    );
  }

  List<LineChartBarData<LightHouseTooltip>> getLineBarsData(
      List<List<FlSpot<LightHouseTooltip>>> data) {
    return data.map((chartData) {
      final color = chartData[0].data.color;
      return LineChartBarData<LightHouseTooltip>(
          isCurved: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                color.withOpacity(.4),
                color.withOpacity(.02),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: color,
            applyCutOffY: true,
            cutOffY: 0.0,
          ),
          dotData: const FlDotData(
            show: false,
            checkToShowDot: showAllDots,
            getDotPainter: defaultGetDotPainter,
          ),
          color: color,
          show: true,
          spots: chartData,
          preventCurveOverShooting: true,
          preventCurveOvershootingThreshold: 0.0);
    }).toList();
  }

  AxisTitles getLeftTitles() {
    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 35 / 5,
        reservedSize: 40,
        getTitlesWidget: (value, meta) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 0.0,
            fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1,
                  height: 8,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(bottom: 4),
                ),
                Text(value.toString(),
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          );
        },
      ),
    );
  }

  AxisTitles getBottomTitles() {
    return AxisTitles(
      drawBelowEverything: false,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: (1696404306.38 - 1696403435.603) / 5,
        getTitlesWidget: (value, meta) {
          final time =
              DateTime.fromMillisecondsSinceEpoch((value * 1000).toInt());
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 0.0,
            fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1,
                  height: 8,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(bottom: 4),
                ),
                Text(DateTimeUtil.formatHm(time),
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          );
        },
      ),
    );
  }
}
