import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/view/changePassword_screen.dart';

class ProfileFormViewmodel extends ChangeNotifier {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  String? checkOldPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkNewPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkBothPasswords(
    BuildContext context,
    AppLocalizations l10n,
    String? passOne,
    String? passTwo,
  ) {
    if (passOne == null || passOne.isEmpty) {
      return l10n.campoVacio;
    } else if ((passOne.compareTo(passTwo!) != 0)) {
      return l10n.contrasenaNoCoincide;
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
