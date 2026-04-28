import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/view/newUserPassword.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class LoginFormViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? checkUser(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkPass(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  void clearForm() {
    userController.clear();
    passController.clear();
  }

  void checkLogin(
    String username,
    String password,
    BuildContext context,
  ) async {
    List<Map<String, dynamic>> user = await context
        .read<DatabaseService>()
        .checkLogin(username, password);
    if (user.isEmpty) {
      context.read<MessagesViewmodel>().showErrorDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4,
        "Usuario y/o contraseña incorrectos",
      );
    } else if (user.first['firstSignin'] == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewUserPassword(idUser: user.first['idUser']),
        ),
      );
    } else {
      context.read<DatabaseService>().updateSession(
        user.first['idUser'],
        user.first['name'],
        user.first['username'],
        user.first['role'],
        user.first['firstSignin'],
      );
    }
  }
}
