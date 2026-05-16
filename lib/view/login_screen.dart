import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_focusChange);
  }

  @override
  void dispose() {
    _emailFocus.removeListener(_focusChange);
    super.dispose();
  }

  void _focusChange() {
    if (!_emailFocus.hasFocus) {
      context.read<LoginFormViewmodel>().emailController.text = context
          .read<LoginFormViewmodel>()
          .emailController
          .text
          .trim();
    }
  }

  GlobalKey<FormState> checkForm = GlobalKey<FormState>();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Center(child: Text(l10n.nombreApp)),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Image.asset(
                  'assets/ribera.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
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
                        focusNode: _emailFocus,
                        validator: (value) => context
                            .read<LoginFormViewmodel>()
                            .checkEmail(value, l10n),
                        controller: context
                            .read<LoginFormViewmodel>()
                            .emailController,
                        decoration: InputDecoration(
                          label: Text(l10n.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: l10n.mostrarContrasena,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () async {
                          if (checkForm.currentState!.validate()) {
                            await context.read<AuthService>().checkLogin(
                              context
                                  .read<LoginFormViewmodel>()
                                  .emailController
                                  .text,
                              context
                                  .read<LoginFormViewmodel>()
                                  .passController
                                  .text,
                              context,
                              l10n,
                            );
                          }
                        },
                        child: Text(l10n.iniciarSesion),
                      ),
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
