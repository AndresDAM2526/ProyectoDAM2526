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

  String? checkName(String? value,AppLocalizations l10n) {
    if (value!.isEmpty || value == null) {
      return l10n.campoVacio;
    }
  }

  String? checkQuantity(String? value,AppLocalizations l10n) {
    if (value!.isEmpty || value == null) {
      return l10n.campoVacio;
    } else if (int.tryParse(value) == null) {
      return l10n.formatoCantidadIncorrecto;
    } else if (int.parse(value) == 0) {
      return l10n.cantidadIncorrecta;
    }
  }

  String? checkType(String? value,AppLocalizations l10n) {
    if (value == null) {
      return l10n.campoVacio;
    }
  }

  String? checkLocation(String? value,AppLocalizations l10n) {
    if (value == null) {
      return l10n.campoVacio;
    }
  }

  void clearForm() {
    nameController.clear();
    quantityController.clear();
    notifyListeners();
  }
}
