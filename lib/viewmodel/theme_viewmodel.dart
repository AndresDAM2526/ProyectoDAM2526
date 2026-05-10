import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewmodel extends ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  ThemeMode get theme => _darkMode ? ThemeMode.dark : ThemeMode.light;

  String _lang = "es";
  String get lang => _lang;

  Locale get currentLang => Locale(_lang);

  ThemeViewmodel() {
    loadPrefs();
  }

  void loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _lang = prefs.getString('lang') ?? "es";
    notifyListeners();
  }

  void changeTheme() async {
    _darkMode = !darkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _darkMode);
  }

  void changeLang(String lang) async {
    _lang = lang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', _lang);
  }
}
