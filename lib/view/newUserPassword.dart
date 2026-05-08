import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';

class NewUserPassword extends StatelessWidget {
  String idUser;
  String email;
  NewUserPassword({super.key, required this.idUser, required this.email});
  @override
  Widget build(BuildContext context) {
    final checkForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Cambiar contraseña")),
      ),
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
                    );
                if (changedPassword) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                }else{
                  print("error");
                }
              }
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
