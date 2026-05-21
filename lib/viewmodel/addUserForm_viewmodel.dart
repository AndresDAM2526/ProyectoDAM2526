import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class AdduserFormViewmodel extends ChangeNotifier {
  final dropDownKey = GlobalKey<FormFieldState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String? role;

  String? checkName(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.campoVacio;
    } else if (RegExp(r'[0-9]').hasMatch(value)) {
      return l10n.formatoNombreIncorrecto;
    }
    return null;
  }

  String? checkUser(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty)
      ? l10n.campoVacio
      : (value.length < 6)
      ? l10n.contrasenaCorta
      : null;
  String? checkRole(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkEmail(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty)
      ? l10n.campoVacio
      : (!value.contains('@'))
      ? l10n.correoIncorrecto
      : null;

  void clearForm() {
    userController.clear();
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    dropDownKey.currentState!.reset();
    role = null;
    notifyListeners();
  }
}
