import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class AddProductFormViewModel extends ChangeNotifier {
  String? type;
  String? location;
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  GlobalKey<FormFieldState> typeDropDown = GlobalKey();
  GlobalKey<FormFieldState> locationDropDown = GlobalKey();

  String? checkName(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkType(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkLocation(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkQuantity(String? value, AppLocalizations l10n) {
    if (value!.isEmpty || value == null) {
      return l10n.campoVacio;
    } else if (int.tryParse(value) == null) {
      return l10n.formatoCantidadIncorrecto;
    }
    int quantity = int.parse(value);
    if (quantity == 0) {
      return l10n.cantidadIncorrecta;
    } else if (quantity < 0) {
      return l10n.cantidadNegativa;
    }
  }

  void clearForm() {
    nameController.clear();
    quantityController.clear();
    typeDropDown.currentState!.reset();
    locationDropDown.currentState!.reset();
    type = null;
    location = null;
    notifyListeners();
  }
}
