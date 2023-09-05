import 'package:intl/intl.dart';

String formatDateTime(String dateStr) {
  final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
  final DateTime date = inputFormat.parse(dateStr);
  final DateFormat dateFormat = DateFormat('dd MMM - yyyy');
  return dateFormat.format(date);
}
