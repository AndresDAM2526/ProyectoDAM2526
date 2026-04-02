import 'package:flutter/material.dart';

class ModifyProductformViewmodel extends ChangeNotifier {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  GlobalKey<FormState> typeDropDown = GlobalKey();
  GlobalKey<FormState> locationDropDown = GlobalKey();

  String? checkName(String? value) =>
      (value!.isEmpty || value == null) ? "Campo vacio" : null;
  String? checkType(String? value) =>
      (value!.isEmpty || value == null) ? "Campo vacio" : null;
  String? checkLocation(String? value) =>
      (value!.isEmpty || value == null) ? "Campo vacio" : null;
  String? checkQuantity  (String? value) => (value!.isEmpty || value == null)
      ? "Campo vacio"
      : (int.tryParse(value) == null)
      ? "El formato no es correcto"
      : null;
}
