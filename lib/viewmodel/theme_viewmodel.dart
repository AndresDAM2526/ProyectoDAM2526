import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewmodel extends ChangeNotifier {
  bool _darkMode = false;
  double _fontSize = 1;
  String _lang = "es";


  bool get darkMode => _darkMode;
  double get fontSize => _fontSize;
  ThemeMode get theme => _darkMode ? ThemeMode.dark : ThemeMode.light;
  String get lang => _lang;
  Locale get currentLang => Locale(_lang);

  ThemeViewmodel() {
    loadPrefs();
  }

  void loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('darkMode') ?? false;
    _lang = prefs.getString('lang') ?? "es";
    _fontSize = prefs.getDouble('fontSize') ?? 1;
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

  void changeFontSize(double size) async {
    _fontSize = size;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', _fontSize);
  }
}
