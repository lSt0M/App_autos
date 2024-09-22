import 'package:intl/intl.dart';

String dateToBackend(DateTime dateTime) {
  String formattedDate = DateFormat(
    'yyyy-MM-ddTHH:mm:ssZ',
    'es_PE',
  ).format(dateTime
      // .subtract(
      // const Duration(hours: 5),
      // ),
      );
  return formattedDate;
}

DateTime dateFromBackend(String dateStr) {
  DateTime dateTime = DateFormat(
    'yyyy-MM-ddTHH:mm:ssZ',
    'es_PE',
  ).parse(dateStr);
  // .subtract(
  //       const Duration(hours: 5),
  //     );
  return dateTime;
}

String dateToDisplay(DateTime dateTime) {
  String formattedDate = DateFormat(
    'dd/MM/yyyy HH:mm',
    'es_PE',
  ).format(dateTime);
  return formattedDate;
}

String dateToDisplayFromBackend(String dateStr) {
  DateTime dateTime = dateFromBackend(dateStr);
  return dateToDisplay(dateTime);
}

String showOnlyDate(String dateStr) {
  DateTime dateTime = dateFromBackend(dateStr);
  return DateFormat(
    'dd/MM/yyyy',
    'es_PE',
  ).format(dateTime);
}

String showOnlyTime(String dateStr) {
  DateTime dateTime = dateFromBackend(dateStr);
  return DateFormat(
    'HH:mm',
    'es_PE',
  ).format(dateTime);
}

DateTime getDateTimeNow() {
  return DateTime.now();
}
