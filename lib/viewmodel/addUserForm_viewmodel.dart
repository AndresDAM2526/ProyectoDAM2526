import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class AdduserFormViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String? role;

  String? checkName(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkUser(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkPassword(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkRole(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkEmail(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  void clearForm() {
    userController.clear();
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    role = null;
  }
}
