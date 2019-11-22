import 'package:intl/intl.dart';

String toBearer(String token) {
  return 'Bearer $token';
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

String mysqlDateTimeFormat = 'yyyy-MM-dd H:mm:ss';

String toMysqlDateTime(DateTime datetime) {
  DateFormat formatter = DateFormat(mysqlDateTimeFormat);
  return formatter.format(datetime);
}

DateTime fromMysqlDateTime(String datetime) {
  DateFormat formatter = DateFormat(mysqlDateTimeFormat);
  return formatter.parse(datetime);
}

String toThaiDate(DateTime datetime, [String format = 'dd MMM yyyy']) {
  final formatter = DateFormat(format, 'th_TH');
  return formatter.format(datetime);
}

String getFirstCharacter(String text) {
  return text[0];
}

class StringUtils {
  static String toRemainingText(Duration duration) {
    String remaining = 'อีก';

    if (duration.inDays >= 365) return '$remaining ${duration.inDays ~/ 365} ปี';
    if (duration.inDays >= 1) return '$remaining ${duration.inDays} วัน';
    if (duration.inHours >= 1) return '$remaining ${duration.inHours} ชั่วโมง';
    if (duration.inMinutes >= 1) return '$remaining ${duration.inMinutes} นาที';
    if (duration.inSeconds >= 1) return '$remaining ${duration.inSeconds} วินาที';

    return remaining;
  }
}
