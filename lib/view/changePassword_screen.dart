import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class ChangePasswordScreen extends StatefulWidget {
  UserDatabase? user;
  ChangePasswordScreen({super.key, required this.user});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cambiar contraseña")),
      body: Form(
        key: checkForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: context
                    .read<AdministrationscreenViewmodel>()
                    .passwordController,
                validator: (value) => context
                    .read<AdministrationscreenViewmodel>()
                    .checkPassword(value),
                decoration: InputDecoration(
                  label: Text("Introduzca la nueva contraseña"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (checkForm.currentState!.validate()) {
                  context.read<DatabaseService>().changePassword(
                    widget.user!.idUser,
                    context
                        .read<AdministrationscreenViewmodel>()
                        .passwordController
                        .text,
                  );
                  context
                      .read<AdministrationscreenViewmodel>()
                      .passwordController
                      .clear();
                  Navigator.pop(context, true);
                  
                } else {
                  Navigator.pop(context, false);
                }
              },
              child: Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}
