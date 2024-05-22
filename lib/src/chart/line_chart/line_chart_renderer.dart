import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/base_chart/base_chart_painter.dart';
import 'package:fl_chart/src/chart/base/base_chart/render_base_chart.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart_painter.dart';
import 'package:fl_chart/src/utils/canvas_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// coverage:ignore-start

/// Low level LineChart Widget.
class LineChartLeaf<T> extends LeafRenderObjectWidget {
  const LineChartLeaf({
    super.key,
    required this.data,
    required this.targetData,
  });

  final LineChartData<T> data;
  final LineChartData<T> targetData;

  @override
  RenderLineChart<T> createRenderObject(BuildContext context) => RenderLineChart(
        context,
        data,
        targetData,
        MediaQuery.of(context).textScaler,
      );

  @override
  void updateRenderObject(BuildContext context, RenderLineChart<T> renderObject) {
    renderObject
      ..data = data
      ..targetData = targetData
      ..textScaler = MediaQuery.of(context).textScaler
      ..buildContext = context;
  }
}
// coverage:ignore-end

/// Renders our LineChart, also handles hitTest.
class RenderLineChart<T> extends RenderBaseChart<LineTouchResponse<T>> {
  RenderLineChart(
    BuildContext context,
    LineChartData<T> data,
    LineChartData<T> targetData,
    TextScaler textScaler,
  )   : _data = data,
        _targetData = targetData,
        _textScaler = textScaler,
        super(
          targetData.lineTouchData,
          context,
        );

  LineChartData<T> get data => _data;
  LineChartData<T> _data;
  set data(LineChartData<T> value) {
    if (_data == value) return;
    _data = value;
    markNeedsPaint();
  }

  LineChartData<T> get targetData => _targetData;
  LineChartData<T> _targetData;
  set targetData(LineChartData<T> value) {
    if (_targetData == value) return;
    _targetData = value;
    super.updateBaseTouchData(_targetData.lineTouchData);
    markNeedsPaint();
  }

  TextScaler get textScaler => _textScaler;
  TextScaler _textScaler;
  set textScaler(TextScaler value) {
    if (_textScaler == value) return;
    _textScaler = value;
    markNeedsPaint();
  }

  // We couldn't mock [size] property of this class, that's why we have this
  @visibleForTesting
  Size? mockTestSize;

  @visibleForTesting
  LineChartPainter<T> painter = LineChartPainter();

  PaintHolder<LineChartData<T>> get paintHolder => PaintHolder(data, targetData, textScaler);

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas
      ..save()
      ..translate(offset.dx, offset.dy);
    painter.paint(
      buildContext,
      CanvasWrapper(canvas, mockTestSize ?? size),
      paintHolder,
    );
    canvas.restore();
  }

  @override
  LineTouchResponse<T> getResponseAtLocation(Offset localPosition) {
    final touchedSpots = painter.handleTouch(
      localPosition,
      mockTestSize ?? size,
      paintHolder,
    );
    return LineTouchResponse<T>(touchedSpots);
  }
}
