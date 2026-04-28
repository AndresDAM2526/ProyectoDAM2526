import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  void updatePassword(
    BuildContext context,
    int idUser,
    String oldPassword,
    String newPassword,
  ) async {
    String currentPass = await context
        .read<DatabaseService>()
        .getPasswordFromUser(idUser);
    if ((currentPass.compareTo(oldPassword) != 0)) {
      context.read<MessagesViewmodel>().showErrorDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2,
        "La contraseña actual no es correcta",
      );
    } else {
      context.read<DatabaseService>().changePasswordNewUser(
        idUser,
        newPassword,
      );
      await context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 2,
        "Se ha actualizado la contraseña",
      );
      Navigator.pop(context);
    }
  }
}
