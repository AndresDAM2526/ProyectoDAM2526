import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
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
    return Scaffold(
      body: SizedBox(
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
                      validator: (value) =>
                          context.read<LoginFormViewmodel>().checkUser(value),
                      controller: context
                          .read<LoginFormViewmodel>()
                          .userController,
                      decoration: InputDecoration(label: Text("Usuario")),
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
                      validator: (value) =>
                          context.read<LoginFormViewmodel>().checkPass(value),
                      controller: context
                          .read<LoginFormViewmodel>()
                          .passController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        label: Text("Contraseña"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            semanticLabel: "Mostrar contraseña",
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (checkForm.currentState!.validate()) {
                        if (await context.read<DatabaseService>().checkLogin(
                              context
                                  .read<LoginFormViewmodel>()
                                  .userController
                                  .text,
                              context
                                  .read<LoginFormViewmodel>()
                                  .passController
                                  .text,
                            ) ==
                            1) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Existe")));
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("No existe")));
                        }
                      }
                    },
                    child: Text("Iniciar sesión"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
