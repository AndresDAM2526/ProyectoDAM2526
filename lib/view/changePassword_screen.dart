import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/profileForm_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/errorMessage_widget.dart';
import 'package:proyecto_dam_2526/widgets/userInformation_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  String? sourceScreen;
  UserDatabase? user;
  ChangePasswordScreen({
    super.key,
    required this.user,
    required this.sourceScreen,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cambiar contraseña")),
      body:
          ((widget.sourceScreen?.compareTo(
                (UserInformationWidget).toString(),
              ) ==
              0))
          ? Form(
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
                    onPressed: () async {
                      if (checkForm.currentState!.validate()) {
                        bool? result = await context
                            .read<SupabaseService>()
                            .changePassword(
                              widget.user!.idUser,
                              context
                                  .read<AdministrationscreenViewmodel>()
                                  .passwordController
                                  .text,
                            );
                        if (result == true) {
                          context
                              .read<AdministrationscreenViewmodel>()
                              .passwordController
                              .clear();
                          Navigator.pop(context, true);
                        }
                      } else {
                        Navigator.pop(context, false);
                      }
                    },
                    child: Text("Enviar"),
                  ),
                ],
              ),
            )
          : Form(
              key: checkForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: context
                        .read<ProfileFormViewmodel>()
                        .oldPasswordController,
                    validator: (value) => context
                        .read<ProfileFormViewmodel>()
                        .checkOldPassword(value),
                    decoration: InputDecoration(
                      label: Text("Introduzca la contraseña actual"),
                    ),
                  ),
                  TextFormField(
                    controller: context
                        .read<ProfileFormViewmodel>()
                        .newPasswordController,
                    validator: (value) => context
                        .read<ProfileFormViewmodel>()
                        .checkNewPassword(value),
                    decoration: InputDecoration(
                      label: Text("Introduzca la nueva contraseña"),
                    ),
                  ),
                  TextFormField(
                    controller: context
                        .read<ProfileFormViewmodel>()
                        .secondPasswordController,
                    validator: (value) =>
                        context.read<ProfileFormViewmodel>().checkBothPasswords(
                          value,
                          context
                              .read<ProfileFormViewmodel>()
                              .newPasswordController
                              .text,
                        ),
                    decoration: InputDecoration(
                      label: Text("Introduzca la nueva contraseña"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (checkForm.currentState!.validate()) {
                        if (context
                                .read<ProfileFormViewmodel>()
                                .checkDatabasePassword(
                                  context,
                                  context
                                      .read<ProfileFormViewmodel>()
                                      .oldPasswordController
                                      .text,
                                  widget.user!.idUser,
                                ) !=
                            true) {
                          context.read<MessagesViewmodel>().showErrorDialog(
                            context,
                            MediaQuery.of(context).size.width / 4,
                            MediaQuery.of(context).size.height / 4,
                            "La contraseña actual no es correcta, inténtelo de nuevo",
                          );
                        }
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
