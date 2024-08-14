import 'dart:math';

import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
  List<FlSpot<LightHouseTooltip>> spotData = [];
  bool showAvg = false;
  List<Offset> _offsets = <Offset>[];
  static const disableAxisTitles = AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  );

  @override
  void initState() {
    List.generate(20, (index) {
      final yRand = Random().nextDouble() * 10;
      spotData.add(FlSpot(
          index.toDouble(), yRand, LightHouseTooltip(timestamp: 123456708, value: 15, nameMetric: "メモリ使用率", color: const Color(0xff01a7d9), fractionDigit: 1)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              avgData(),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData<LightHouseTooltip> avgData() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      showingTooltipIndicators: [const ShowingTooltipIndicators([])],
      maxX: spotData.last.x,
      minX: spotData.first.x,
      maxY: 10,
      minY: 0,
      lineTouchData: LineTouchData(
        longPressDuration: const Duration(milliseconds: 50),
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 16,
          tooltipPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          tooltipMargin: 0,
          shadowColor: Random().nextBool() ? Colors.grey.withOpacity(0.5) : const Color.fromARGB(0, 15, 14, 14),
          getTooltipColor: (touchedSpot) => const Color(0xFF3b3f4b),
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((e) {
              return LineTooltipItem(
                e.y.toString(),
                isBoolChart: true,
                value: "truiong",
                // isShowName: true,
                customDataChart: e.data,
                textStyleDate: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700),
                textStyleHour: const TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textStyleName: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
                textStyleValue: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList();
          },
        ),
        touchCallback: (touchEvent, lineTouchRsp) {
          // if (touchEvent is FlLongPressStart) {
          //   _offsets.add(touchEvent.details.localPosition);
          // } else if (touchEvent is FlLongPressEnd) {
          //   _offsets.clear();
          //   isRepaint = false;
          //   if (actualMinAxis != null && actualMaxAxis != null) {
          //     final isAllow = selectProvider.setZoom(actualMinAxis, actualMaxAxis);
          //     if (!isAllow) {
          //       Future.delayed(const Duration(milliseconds: 100), () {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text(
          //               alertSelectedArea,
          //               maxLines: 1,
          //               textAlign: TextAlign.center,
          //               style: textTheme.bodyLarge?.copyWith(
          //                 color: colorWhite,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 14,
          //                 fontStyle: FontStyle.normal,
          //                 letterSpacing: 0.3,
          //                 height: 1,
          //               ),
          //             ),
          //             backgroundColor: const Color.fromRGBO(247, 123, 116, 1),
          //             behavior: SnackBarBehavior.floating,
          //             duration: const Duration(seconds: 3),
          //             elevation: 1.0,
          //             width: 270,
          //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //           ),
          //         );
          //       });
          //       actualMaxAxis = null;
          //       actualMaxAxis = null;
          //     }
          //   } else {
          //     Future.delayed(const Duration(milliseconds: 1), () {});
          //   }
          // } else if (touchEvent is FlLongPressMoveUpdate) {
          //   ref.read(toolTipStateProvider.notifier).turnOffTooltip();
          //   _offsets.add(touchEvent.details.localPosition);
          // }
        },
        getTouchLineEnd: <LightHouseTooltip>(data, index) => double.infinity,
        getTouchedSpotIndicator: (barData, spotIndexes) {
          return spotIndexes.map((e) {
            return TouchedSpotIndicatorData<LightHouseTooltip>(
              FlLine(strokeWidth: 1, color: Colors.black),
              FlDotData<LightHouseTooltip>(
                checkToShowDot: (spot, barData) => true,
                getDotPainter: (spot, xPercentage, bar, index) {
                  // if (spot.data != null) {
                  //   final p = spot.data!;
                  //   final timeChart = DateTimeUtil.convertMillisecondToDateTime(p.timestamp.toInt());
                  //   ref.read(toolTipStateProvider.notifier).passDataInTooltip(
                  //       dateTime: timeChart,
                  //       isBoolChart: widget.isChartBool,
                  //       value: p.value as double,
                  //       color: p.color,
                  //       unit: widget.unit,
                  //       labelBool0: widget.labelBool0 ?? "",
                  //       labelBool1: widget.labelBool1 ?? "",
                  //       name: widget.metrics.length > 1 ? p.nameMetric : "",
                  //       valueType: widget.metrics[0].metric_value_type,
                  //       fractionDigit: p.fractionDigit);
                  // }
                  return FlDotCirclePainter<LightHouseTooltip>(color: spot.data?.color ?? Colors.red, radius: 8);
                },
              ),
            );
          }).toList();
        },
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(bottom: BorderSide(width: 2, color: Colors.red), top: BorderSide(width: 1, color: Colors.yellow)),
      ),
      titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              interval: 2,
              showTitles: true,
              getTitlesWidget: (value, meta) => Text(
                value.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            interval: 5,
            reservedSize: 30,
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              value.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ))),
      lineBarsData: getLineBarsData(),
    );
  }

  List<LineChartBarData<LightHouseTooltip>> getLineBarsData() {
    return [
      LineChartBarData<LightHouseTooltip>(
          isCurved: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(.4),
                Colors.blue.withOpacity(.02),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: Colors.blue,
          ),
          dotData: const FlDotData(
            show: false,
            checkToShowDot: showAllDots,
            getDotPainter: defaultGetDotPainter,
          ),
          color: Colors.blue,
          show: true,
          spots: spotData,
          preventCurveOverShooting: false,
          preventCurveOvershootingThreshold: false ? 0.0 : 10.0),
    ];
  }
}


final spotData = <FlSpot<LightHouseTooltip>>[
  FlSpot(1723605896, 15, LightHouseTooltip(timestamp: 1723605896000, value: 15, nameMetric: "メモリ使用率", color: const Color(0xff01a7d9), fractionDigit: 1),),
  FlSpot(1723606196, 15, LightHouseTooltip(timestamp: 1723606196000, value: 15, nameMetric: "メモリ使用率", color: const Color(0xff01a7d9), fractionDigit: 1),),
  FlSpot(1723606496, 15, LightHouseTooltip(timestamp: 1723606496000, value: 15, nameMetric: "メモリ使用率", color: const Color(0xff01a7d9), fractionDigit: 1),),
];