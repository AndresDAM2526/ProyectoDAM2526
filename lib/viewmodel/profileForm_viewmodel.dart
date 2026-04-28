import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/view/changePassword_screen.dart';

class ProfileFormViewmodel extends ChangeNotifier {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

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

  void showModifyPasswordDialog(
    BuildContext context,
    UserDatabase user,
    String sourceScreen,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: ChangePasswordScreen(user: user, sourceScreen: sourceScreen),
          ),
        );
      },
    );
  }

  Future<bool> checkDatabasePassword(
    BuildContext context,
    String password,
    String idUser,
  ) async {
    String oldPassword = await context
        .read<DatabaseService>()
        .getPasswordFromUser(idUser);
    if (oldPassword.compareTo(password) != 0) {
      return false;
    }
    return true;
  }
}
