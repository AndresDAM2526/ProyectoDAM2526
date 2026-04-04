import 'package:flutter/material.dart';

class LoginFormViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? checkUser(String? value) =>
      (value == null || value!.isEmpty) ? "Campo vacio" : "";
  String? checkPass(String? value) =>
      (value == null || value!.isEmpty) ? "Campo vacio" : "";
}
