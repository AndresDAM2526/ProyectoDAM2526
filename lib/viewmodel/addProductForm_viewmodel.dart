import 'package:flutter/material.dart';
import 'package:path/path.dart';
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

  String? checkName(String? value) {
    if (value!.isEmpty || value == null) {
      return "Campo vacío";
    }
  }

  String? checkQuantity(String? value) {
    if (value!.isEmpty || value == null) {
      return "Campo vacío";
    } else if (int.tryParse(value) == null) {
      return "El formato de la cantidad no es correcto";
    } else if (int.parse(value) == 0) {
      return "Cantidad incorrecta";
    }
  }

  String? checkType(String? value) {
    if (value == null) {
      return "Campo vacío";
    }
  }

  String? checkLocation(String? value) {
    if (value == null) {
      return "Campo vacío";
    }
  }

  void clearForm() {
    nameController.clear();
    quantityController.clear();
    notifyListeners();
  }
}
