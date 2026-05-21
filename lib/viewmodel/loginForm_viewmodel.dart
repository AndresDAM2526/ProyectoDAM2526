import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class LoginFormViewmodel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? checkEmail(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkPass(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  void clearForm() {
    emailController.clear();
    passController.clear();
  }
}
