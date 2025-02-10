

import 'package:intl/intl.dart';

abstract class DateTimeHelper {
  static String formatDateMonthDayYear({required String date}) {
    if(date.isEmpty)return"";
    return DateFormat("MM/dd/yyyy")
        .format(DateTime.parse(date).toLocal());
  }
  static String formatMillisecondsToDate({required int milliseconds}) {
    if (milliseconds <= 0) return "";
    return DateFormat("MM/dd/yyyy")
        .format(DateTime.fromMillisecondsSinceEpoch(milliseconds).toLocal());
  }
  static String formatDateObjectMonthDayYear({required DateTime? date}) {
    if(date == null) return"";
    return DateFormat("MM/dd/yyyy")
        .format(date.toLocal());
  }
  static String formatDataObjectWithDashBetween({required DateTime? date}) {
    if(date == null) return"";
    return DateFormat("yyyy-MM-dd",'en_US')
        .format(date.toLocal());
  }
  static DateTime convertToLocal({required DateTime date}) {
    return date.toLocal();
  }
    static num? convertToMilliseconds({required DateTime? date}) {
      if(date == null) return null;
      return date.millisecondsSinceEpoch;

  }

  static String? convertFromSlashFormatToDashFormat({required String? date}) {
    if ((date ?? "").isEmpty) return null;

    List<String> parts = date!.split("/");
    if (parts.length != 3) return null;

    String formattedDate = '${parts[2]}-${parts[0]}-${parts[1]}'; // day-month-year
    return formattedDate;
  }


}
