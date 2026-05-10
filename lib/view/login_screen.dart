import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/view/newUserPassword.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> checkForm = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(l10n.nombreApp)),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/ribera.png',
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              Form(
                key: checkForm,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                        bottom: 10,
                      ),
                      child: TextFormField(
                        validator: (value) => context
                            .read<LoginFormViewmodel>()
                            .checkUser(value, l10n),
                        controller: context
                            .read<LoginFormViewmodel>()
                            .userController,
                        decoration: InputDecoration(label: Text(l10n.usuario)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                        bottom: 30,
                      ),
                      child: TextFormField(
                        validator: (value) => context
                            .read<LoginFormViewmodel>()
                            .checkPass(value, l10n),
                        controller: context
                            .read<LoginFormViewmodel>()
                            .passController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          label: Text(l10n.contrasena),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              semanticLabel: l10n.mostrarContrasena,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (checkForm.currentState!.validate()) {
                          await context.read<AuthService>().checkLogin(
                            context
                                .read<LoginFormViewmodel>()
                                .userController
                                .text,
                            context
                                .read<LoginFormViewmodel>()
                                .passController
                                .text,
                            context,
                          );
                        }
                      },
                      child: Text(l10n.iniciarSesion),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
