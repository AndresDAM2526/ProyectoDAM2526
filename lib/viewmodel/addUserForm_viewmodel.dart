import 'package:flutter/material.dart';

class AdduserFormViewmodel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? role;

  String? checkName(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkUser(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkPassword(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkRole(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  void clearForm() {
    nameController.clear();
    userController.clear();
    passwordController.clear();
    role = null;
  }
}
