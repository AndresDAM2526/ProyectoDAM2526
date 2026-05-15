import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
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
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.cambiarContrasena),
        backgroundColor: AppColors.primary,
      ),
      body:
          ((widget.sourceScreen?.compareTo(
                (UserInformationWidget).toString(),
              ) ==
              0))
          ? SingleChildScrollView(
              child: Form(
                key: checkForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: context
                            .read<AdministrationscreenViewmodel>()
                            .passwordController,
                        validator: (value) => context
                            .read<AdministrationscreenViewmodel>()
                            .checkPassword(value, l10n),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          errorMaxLines: 2,
                          label: Text(l10n.nuevaContrasena),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                      ),
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
                                context,
                              );
                          if (result == true) {
                            context
                                .read<AdministrationscreenViewmodel>()
                                .passwordController
                                .clear();
                            Navigator.pop(context, true);
                          }
                        }
                      },
                      child: Text(l10n.enviar),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: checkForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<ProfileFormViewmodel>()
                            .oldPasswordController,
                        validator: (value) => context
                            .read<ProfileFormViewmodel>()
                            .checkOldPassword(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.contrasenaActual),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<ProfileFormViewmodel>()
                            .newPasswordController,
                        validator: (value) => context
                            .read<ProfileFormViewmodel>()
                            .checkNewPassword(value, l10n),
                        decoration: InputDecoration(
                          label: Text(l10n.nuevaContrasena),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<ProfileFormViewmodel>()
                            .secondPasswordController,
                        validator: (value) => context
                            .read<ProfileFormViewmodel>()
                            .checkBothPasswords(
                              context,
                              l10n,
                              value,
                              context
                                  .read<ProfileFormViewmodel>()
                                  .newPasswordController
                                  .text,
                            ),
                        decoration: InputDecoration(
                          label: Text(l10n.nuevaContrasena),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.black,
                      ),
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
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height / 3,
                              l10n.contrasenaActualIncorrecta,
                            );
                          }
                        }
                      },
                      child: Text(l10n.enviar),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
