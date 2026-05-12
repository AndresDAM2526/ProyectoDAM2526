import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/view/addLocation_screen.dart';
import 'package:proyecto_dam_2526/view/addTypeProduct_screen.dart';
import 'package:proyecto_dam_2526/view/changePassword_screen.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';
import 'package:proyecto_dam_2526/view/modifyUserPropierties_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class AdministrationscreenViewmodel extends ChangeNotifier {
  TextEditingController userController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedRole;

  String? checkName(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;
  String? checkLocation(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkTypeProduct(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkPassword(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  String? checkRole(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty) ? l10n.campoVacio : null;

  void clearLocation() {
    locationController.clear();
    notifyListeners();
  }

  void showAddLocationDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width:  MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 2,
            child: AddlocationScreen(),
          ),
        );
      },
    );

    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.nuevaUbicacionMensaje)));
    }
  }

  void showAddTypeProductDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 2,
            child: AddTypeProduct(),
          ),
        );
      },
    );

    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.nuevoTipoMensaje)));
    }
  }

  void showChangePasswordDialog(
    BuildContext context,
    AppLocalizations l10n,
    UserDatabase user,
    String sourceScreen,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 2,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 2,
            child: ChangePasswordScreen(user: user, sourceScreen: sourceScreen),
          ),
        );
      },
    );
    if (result == true) {
      context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
        l10n.modificarContrasenaMensaje,
      );
    }
  }

  void showModifyPropertiesUserDialog(
    BuildContext context,
    AppLocalizations l10n,
    UserDatabase user,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height,
            child: ModifyUserPropiertiesScreen(user: user),
          ),
        );
      },
    );
    if (result == true) {
      context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4,
        l10n.modificarUsuarioMensaje,
      );
    }
  }

  void showModifyProductDialog(
    BuildContext context,
    AppLocalizations l10n,
    DatabaseProduct product,
  ) async {
    final bool? modified = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.height / 2
                  : MediaQuery.of(context).size.height,
              child: ModifyProductScreen(product: product),
            ),
          ),
        );
      },
    );

    if (modified == true) {
      context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4,
        l10n.modificarProductoMensaje,
      );
    }
  }
}
