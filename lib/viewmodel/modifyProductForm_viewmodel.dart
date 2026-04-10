import 'package:flutter/material.dart';

class ModifyProductFormViewmodel extends ChangeNotifier {
  String? nameProperty;
  String? typeProperty;
  String? locationProperty;
  String? quantity;

  GlobalKey<FormFieldState> typeDropDown = GlobalKey();
  GlobalKey<FormFieldState> locationDropDown = GlobalKey();

  String? checkName(String? value) =>
      (value!.isEmpty || value == null) ? "Campo vacio" : null;
  String? checkType(String? value) => (value == null) ? "Campo vacio" : null;
  String? checkLocation(String? value) =>
      (value == null) ? "Campo vacio" : null;
  String? checkQuantity(String? value) => (value!.isEmpty || value == null)
      ? "Campo vacio"
      : (int.tryParse(value) == null)
      ? "El formato no es correcto"
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
