import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

class NewUserPasswordFormViewModel extends ChangeNotifier {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController secondPassword = TextEditingController();

  String? checkOldPassword(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkNewPassword(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkBothPasswords(String? passOne, String? passTwo) {
    if (passOne == null || passOne.isEmpty) {
      return "Campo vacío";
    } else if ((passOne.compareTo(passTwo!) != 0)) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  Future<bool> updatePassword(
    String idUser,
    String email,
    String oldPassword,
    String newPassword,
    BuildContext context,
  ) async {
    bool changedPassword = await context.read<AuthService>().updatePassword(
      idUser,
      email,
      oldPassword,
      newPassword,
      context,
    );
    if (changedPassword == true) {
      await context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2,
        "Se ha actualizado la contraseña",
      );
      notifyListeners();
      return true;
    }
    return false;
  }
}
