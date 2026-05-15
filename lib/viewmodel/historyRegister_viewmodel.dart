import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryRegisterViewmodel extends ChangeNotifier {
  String parseDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat format = DateFormat.yMd().add_jm();
    return format.format(date);
  }
}
