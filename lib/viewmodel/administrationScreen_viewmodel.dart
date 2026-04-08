import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/view/addLocation_screen.dart';
import 'package:proyecto_dam_2526/view/addTypeProduct_screen.dart';
import 'package:proyecto_dam_2526/view/changePassword_screen.dart';
import 'package:proyecto_dam_2526/view/modifyUserPropierties_screen.dart';

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
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 4,
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
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 4,
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

  void showChangePasswordDialog(BuildContext context, UserDatabase user) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            child: ChangePasswordScreen(user: user),
          ),
        );
      },
    );
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Se ha modificado la contraseña")));
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
          child: SizedBox(child: ModifyUserPropiertiesScreen(user: user)),
        );
      },
    );
    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Se ha modificado el usuario")));
    }
  }
}
