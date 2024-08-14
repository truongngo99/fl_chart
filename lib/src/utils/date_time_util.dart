import 'package:intl/intl.dart';
class DateTimeUtil {
  static String formatyMd(DateTime dateTime) {
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }
  static String formatHm(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
  static DateTime convertMillisecondToDateTime(int millisecond) {
    return DateTime.fromMillisecondsSinceEpoch(millisecond);
  }
}
