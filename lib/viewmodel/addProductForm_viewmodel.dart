import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proyecto_dam_2526/model/Product.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:sqflite/sqflite.dart';

class AddProductoFormViewModel extends ChangeNotifier {
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
    typeDropDown.currentState!.reset();
    locationDropDown.currentState!.reset();
    notifyListeners();
  }
}
