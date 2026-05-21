import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:sqflite/sqflite.dart';

class NewUserPasswordFormViewModel extends ChangeNotifier {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController secondPassword = TextEditingController();

  String? checkOldPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty)
      ? l10n.campoVacio
      : (value.length < 6)
      ? l10n.contrasenaCorta
      : null;
  String? checkNewPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty)
      ? l10n.campoVacio
      : (value.length < 6)
      ? l10n.contrasenaCorta
      : null;
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

  void clearForm() {
    oldPassword.clear();
    newPassword.clear();
    secondPassword.clear();
    notifyListeners();
  }

  Future<bool> updatePassword(
    String idUser,
    String email,
    String oldPassword,
    String newPassword,
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    bool changedPassword = await context.read<AuthService>().updatePassword(
      idUser,
      email,
      oldPassword,
      newPassword,
      context,
      l10n,
    );
    if (changedPassword == true) {
      clearForm();
      await context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width,
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height / 3
            : MediaQuery.of(context).size.height * 0.6,
        l10n.contrasenaActualizada,
      );

      notifyListeners();
      return true;
    }
    return false;
  }
}
