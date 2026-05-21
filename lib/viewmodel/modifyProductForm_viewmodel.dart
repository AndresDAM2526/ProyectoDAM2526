import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class ModifyProductFormViewmodel extends ChangeNotifier {
  String? nameProperty;
  String? typeProperty;
  String? locationProperty;
  String? quantity;

  GlobalKey<FormFieldState> typeDropDown = GlobalKey();
  GlobalKey<FormFieldState> locationDropDown = GlobalKey();

  String? checkName(String? value, AppLocalizations l10n) =>
      (value!.isEmpty || value == null) ? l10n.campoVacio : null;
  String? checkType(String? value, AppLocalizations l10n) =>
      (value == null) ? l10n.campoVacio : null;
  String? checkLocation(String? value, AppLocalizations l10n) =>
      (value == null) ? l10n.campoVacio : null;
  String? checkQuantity(String? value, AppLocalizations l10n) =>
      (value!.isEmpty || value == null)
      ? l10n.campoVacio
      : (int.tryParse(value) == null)
      ? l10n.formatoIncorrecto
      : null;

  void clearForm() {
    nameProperty = "";
    typeProperty = "";
    locationProperty = "";
    quantity = null;
    typeDropDown.currentState!.reset();
    notifyListeners();
  }
}
