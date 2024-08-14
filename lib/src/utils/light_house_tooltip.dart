import 'package:flutter/material.dart';

class LightHouseTooltip {
  LightHouseTooltip({required this.timestamp, required this.value, required this.nameMetric, required this.color, this.fractionDigit});
  final double timestamp;
  final dynamic value;
  final String nameMetric;
  final int? fractionDigit;
  final Color color;
}
