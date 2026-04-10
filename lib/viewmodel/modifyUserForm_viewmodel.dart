import 'package:flutter/material.dart';

class ModifyUserFormViewmodel extends ChangeNotifier {
  String? usernameProperty;
  String? nameProperty;
  String? roleProperty;

  String? checkUsername(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkName(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkRole(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  void clearForm() {
    usernameProperty = null;
    nameProperty = null;
    roleProperty = null;
  }
}
