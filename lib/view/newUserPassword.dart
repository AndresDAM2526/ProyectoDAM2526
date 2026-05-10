import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/main.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';

class NewUserPassword extends StatelessWidget {
  String idUser;
  String email;
  NewUserPassword({super.key, required this.idUser, required this.email});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final checkForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(l10n.cambiarContrasena)),
      ),
      body: Column(
        children: [
          Text(l10n.nuevoUsuario),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(l10n.nuevoUsuarioPantalla),
          ),
          Form(
            key: checkForm,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(l10n.contrasenaActual),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .oldPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkOldPassword(value, l10n),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(l10n.nuevaContrasena),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .newPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkNewPassword(value, l10n),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(l10n.confirmarContrasena),
                    ),
                    controller: context
                        .read<NewUserPasswordFormViewModel>()
                        .secondPassword,
                    validator: (value) => context
                        .read<NewUserPasswordFormViewModel>()
                        .checkBothPasswords(
                          context,
                          l10n,
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
            onPressed: () async {
              if (checkForm.currentState!.validate()) {
                bool changedPassword = await context
                    .read<NewUserPasswordFormViewModel>()
                    .updatePassword(
                      idUser,
                      email,
                      context
                          .read<NewUserPasswordFormViewModel>()
                          .oldPassword
                          .text,
                      context
                          .read<NewUserPasswordFormViewModel>()
                          .newPassword
                          .text,
                      context,
                      l10n,
                    );
                if (changedPassword) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                    (route) => false,
                  );
                }
              }
            },
            child: Text(l10n.enviar),
          ),
        ],
      ),
    );
  }
}
