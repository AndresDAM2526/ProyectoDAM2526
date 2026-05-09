import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewmodel extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  ThemeMode get theme => _darkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeViewmodel() {
    loadPrefs();
  }

  void loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  void changeTheme() async {
    _darkMode = !darkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
  }
}
