import 'package:flutter/material.dart';

class ChartModel {
  final double timestamp;
  final dynamic value;
  final String nameMetric;
  final int? fractionDigit;
  final Color color;
  ChartModel({required this.timestamp, required this.value, required this.nameMetric, required this.color, this.fractionDigit});
}