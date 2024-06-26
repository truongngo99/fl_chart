import 'package:fl_chart/fl_chart.dart';

extension FlSpotListExtension<T> on List<FlSpot<T>> {
  /// Splits a line by [FlSpot.nullSpot] values inside it.
  List<List<FlSpot<T>>> splitByNullSpots() {
    final barList = <List<FlSpot<T>>>[[]];

    // handle nullability by splitting off the list into multiple
    // separate lists when separated by nulls
    for (final spot in this) {
      if (spot.isNotNull()) {
        barList.last.add(spot);
      } else if (barList.last.isNotEmpty) {
        barList.add([]);
      }
    }
    // remove last item if one or more last spots were null
    if (barList.last.isEmpty) {
      barList.removeLast();
    }
    return barList;
  }
}
