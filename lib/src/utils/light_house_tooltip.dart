import 'package:flutter/material.dart';

class LightHouseTooltip {
   LightHouseTooltip({
    this.timestamp = 12345567890,
    this.value = 0,
    this.nameMetric = '',
    this.color = const Color(0xFF000000),
    this.fractionDigit,
  });

  final double timestamp;
  final dynamic value;
  final String nameMetric;
  final int? fractionDigit;
  final Color color;

  @override
  String toString() {
    return 'NameMetric: $nameMetric, Timestamp: $timestamp, Value: $value, FractionDigit: $fractionDigit, color: $color';
  }
}
