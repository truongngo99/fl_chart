import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/base/base_chart/base_chart_painter.dart';
import 'package:fl_chart/src/chart/base/base_chart/render_base_chart.dart';
import 'package:fl_chart/src/chart/radar_chart/radar_chart_painter.dart';
import 'package:fl_chart/src/utils/canvas_wrapper.dart';
import 'package:flutter/cupertino.dart';

// coverage:ignore-start

/// Low level RadarChart Widget.
class RadarChartLeaf<T> extends LeafRenderObjectWidget {
  const RadarChartLeaf({
    super.key,
    required this.data,
    required this.targetData,
  });

  final RadarChartData<T> data;
  final RadarChartData<T> targetData;

  @override
  RenderRadarChart<T> createRenderObject(BuildContext context) => RenderRadarChart(
        context,
        data,
        targetData,
        MediaQuery.of(context).textScaler,
      );

  @override
  void updateRenderObject(BuildContext context, RenderRadarChart<T> renderObject) {
    renderObject
      ..data = data
      ..targetData = targetData
      ..textScaler = MediaQuery.of(context).textScaler
      ..buildContext = context;
  }
}
// coverage:ignore-end

/// Renders our RadarChart, also handles hitTest.
class RenderRadarChart<T> extends RenderBaseChart<RadarTouchResponse> {
  RenderRadarChart(
    BuildContext context,
    RadarChartData<T> data,
    RadarChartData<T> targetData,
    TextScaler textScaler,
  )   : _data = data,
        _targetData = targetData,
        _textScaler = textScaler,
        super(targetData.radarTouchData, context);

  RadarChartData<T> get data => _data;
  RadarChartData<T> _data;

  set data(RadarChartData<T> value) {
    if (_data == value) return;
    _data = value;
    markNeedsPaint();
  }

  RadarChartData<T> get targetData => _targetData;
  RadarChartData<T> _targetData;

  set targetData(RadarChartData<T> value) {
    if (_targetData == value) return;
    _targetData = value;
    super.updateBaseTouchData(_targetData.radarTouchData);
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
  RadarChartPainter<T> painter = RadarChartPainter();

  PaintHolder<T,RadarChartData<T>> get paintHolder =>
      PaintHolder(data, targetData, textScaler);

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
  RadarTouchResponse getResponseAtLocation(Offset localPosition) {
    final touchedSpot = painter.handleTouch(
      localPosition,
      mockTestSize ?? size,
      paintHolder,
    );
    return RadarTouchResponse(touchedSpot);
  }
}
