import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class ModifyUserFormViewmodel extends ChangeNotifier {
  String? emailProperty;
  String? usernameProperty;
  String? nameProperty;
  String? roleProperty;

  String? checkEmail(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkUsername(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkName(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkRole(String? value,AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  void clearForm() {
    usernameProperty = null;
    nameProperty = null;
    roleProperty = null;
    emailProperty = null;
  }
}
