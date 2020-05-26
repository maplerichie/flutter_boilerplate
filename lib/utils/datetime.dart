import 'package:intl/intl.dart';

class DateTimeUtils {
  String epochToDateStr(int dt) {
    var date = new DateTime.fromMillisecondsSinceEpoch(dt);
    return DateFormat.yMMMd().add_jms().format(date);
  }
}
