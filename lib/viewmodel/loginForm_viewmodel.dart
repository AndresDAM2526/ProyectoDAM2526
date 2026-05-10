import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class LoginFormViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? checkUser(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkPass(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  void clearForm() {
    userController.clear();
    passController.clear();
  }
}
