import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/bar_chart/bar_chart_painter.dart';
import 'package:fl_chart/src/chart/base/base_chart/base_chart_painter.dart';
import 'package:fl_chart/src/chart/base/base_chart/render_base_chart.dart';
import 'package:fl_chart/src/utils/canvas_wrapper.dart';
import 'package:flutter/cupertino.dart';

// coverage:ignore-start

/// Low level BarChart Widget.
class BarChartLeaf<T> extends LeafRenderObjectWidget {
  const BarChartLeaf({super.key, required this.data, required this.targetData});

  final BarChartData<T> data;
  final BarChartData<T> targetData;

  @override
  RenderBarChart<T> createRenderObject(BuildContext context) => RenderBarChart(
        context,
        data,
        targetData,
        MediaQuery.of(context).textScaler,
      );

  @override
  void updateRenderObject(BuildContext context, RenderBarChart<T> renderObject) {
    renderObject
      ..data = data
      ..targetData = targetData
      ..textScaler = MediaQuery.of(context).textScaler
      ..buildContext = context;
  }
}
// coverage:ignore-end

/// Renders our BarChart, also handles hitTest.
class RenderBarChart<T> extends RenderBaseChart<BarTouchResponse<T>> {
  RenderBarChart(
    BuildContext context,
    BarChartData<T> data,
    BarChartData<T> targetData,
    TextScaler textScaler,
  )   : _data = data,
        _targetData = targetData,
        _textScaler = textScaler,
        super(targetData.barTouchData, context);

  BarChartData<T> get data => _data;
  BarChartData<T> _data;

  set data(BarChartData<T> value) {
    if (_data == value) return;
    _data = value;
    markNeedsPaint();
  }

  BarChartData<T> get targetData => _targetData;
  BarChartData<T> _targetData;

  set targetData(BarChartData<T> value) {
    if (_targetData == value) return;
    _targetData = value;
    super.updateBaseTouchData(_targetData.barTouchData);
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
  BarChartPainter<T> painter = BarChartPainter();

  PaintHolder<T,BarChartData<T>> get paintHolder =>
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
  BarTouchResponse<T> getResponseAtLocation(Offset localPosition) {
    final touchedSpot = painter.handleTouch(
      localPosition,
      mockTestSize ?? size,
      paintHolder,
    );
    return BarTouchResponse(touchedSpot);
  }
}
