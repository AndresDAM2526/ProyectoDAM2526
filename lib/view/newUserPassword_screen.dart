import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/main.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';

class NewUserPassword extends StatefulWidget {
  String idUser;
  String email;
  NewUserPassword({super.key, required this.idUser, required this.email});

  @override
  State<NewUserPassword> createState() => _NewUserPasswordState();
}

class _NewUserPasswordState extends State<NewUserPassword> {
  bool showCurrentPass = true;

  bool showNewPass = true;

  bool showConfirmPass = true;

  final checkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(l10n.cambiarContrasena)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(l10n.nuevoUsuarioPantalla),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: checkForm,
              child: Column(
                children: [
                  Semantics(
                    label: l10n.accLabelActualPass,
                    hint: l10n.accHintActualPass,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: showCurrentPass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showCurrentPass = !showCurrentPass;
                              });
                            },
                            icon: Semantics(
                              label: l10n.accLabelBtnMostrarPass,
                              hint: l10n.accHintBtnMostrarPass,
                              child: Icon(
                                showCurrentPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(),
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
                  ),
                  Semantics(
                    label: l10n.accLabelNuevaPass,
                    hint: l10n.accHintNuevaPass,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: showNewPass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showNewPass = !showNewPass;
                              });
                            },
                            icon: Semantics(
                              label: l10n.accLabelBtnMostrarPass,
                              hint: l10n.accHintBtnMostrarPass,
                              child: Icon(
                                showNewPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(),
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
                  ),
                  Semantics(
                    label: l10n.accLabelConfirmarPass,
                    hint: l10n.accHintConfirmarPass,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: showConfirmPass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showConfirmPass = !showConfirmPass;
                              });
                            },
                            icon: Icon(
                              showConfirmPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Semantics(
              label: l10n.accLabelBtnEnviar,
              hint: l10n.accHintBtnEnviar,
              child: ElevatedButton(
                onPressed: () async {
                  if (checkForm.currentState!.validate()) {
                    bool changedPassword = await context
                        .read<NewUserPasswordFormViewModel>()
                        .updatePassword(
                          widget.idUser,
                          widget.email,
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
            ),
          ],
        ),
      ),
    );
  }
}
