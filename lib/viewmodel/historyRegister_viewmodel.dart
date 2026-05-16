import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryRegisterViewmodel extends ChangeNotifier {
  String parseDateToString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat format = DateFormat('dd/MM/yyyy HH:mm');
    return format.format(date);
  }
}
