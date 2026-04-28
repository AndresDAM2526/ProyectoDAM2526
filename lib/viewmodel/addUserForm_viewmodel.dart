import 'package:flutter/material.dart';

class AdduserFormViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
  String? checkEmail(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  void clearForm() {
    userController.clear();
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    role = null;
  }
}
