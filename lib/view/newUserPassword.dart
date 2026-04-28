import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';

class NewUserPassword extends StatelessWidget {
  String idUser;
  NewUserPassword({super.key, required this.idUser});
  @override
  Widget build(BuildContext context) {
    final checkForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text("Cambiar contraseña")),
      body: Column(
        children: [
          Text("Nuevo usuario"),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Esta cuenta ha sido creada recientemente, debe cambiar la contraseña para poder acceder por primera vez",
            ),
          ),
          Form(
            key: checkForm,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Contraseña actual"),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .oldPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkOldPassword(value),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Nueva contraseña"),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .newPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkNewPassword(value),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text("Confirmar contraseña"),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .secondPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkBothPasswords(
                          value,
                          context
                              .read<NewUserPasswordFormViewModel>()
                              .newPassword
                              .text,
                        ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (checkForm.currentState!.validate()) {
                context.read<NewUserPasswordFormViewModel>().updatePassword(
                  context,
                  idUser,
                  context.read<NewUserPasswordFormViewModel>().oldPassword.text,
                  context.read<NewUserPasswordFormViewModel>().newPassword.text,
                );
              }
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
