import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  String? checkName(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;
  String? checkLocation(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  String? checkTypeProduct(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  String? checkPassword(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  String? checkRole(String? value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : null;

  void showAddLocationDialog(BuildContext context) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 4
                : MediaQuery.of(context).size.height / 2,
            child: AddlocationScreen(),
          ),
        );
      },
    );

    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Se ha añadido la nueva ubicacion")),
      );
    }
  }

  void showAddTypeProductDialog(BuildContext context) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 4
                : MediaQuery.of(context).size.height / 2,
            child: AddTypeProduct(),
          ),
        );
      },
    );

    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Se ha añadido el nuevo tipo")));
    }
  }

  void showChangePasswordDialog(
    BuildContext context,
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
                ? MediaQuery.of(context).size.height / 5
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
        "Se ha modificado la contraaseña",
      );
    }
  }

  void showModifyPropertiesUserDialog(
    BuildContext context,
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
        "Se ha modificado el usuario",
      );
    }
  }

  void showModifyProductDialog(
    BuildContext context,
    DatabaseProduct product,
  ) async {
    final bool? modified = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
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
        "Se ha modificado el producto",
      );
    }
  }
}
