import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/viewmodel/profileForm_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  UserDatabase? user;
  ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.perfil)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Semantics(
              label: l10n.accLabelCampoUsuarioPerfil,
              hint: l10n.accHintCampoUsuarioPerfil,
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 22,
                        bottom: 8,
                      ),
                      child: Text(l10n.usuario),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.user!.username),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Semantics(
              label: l10n.accLabelCampoCorreo,
              hint: l10n.accHintCampoCorreo,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 40,
                        bottom: 8,
                      ),
                      child: Text(l10n.email),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.user!.email),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Semantics(
              label: l10n.accLabelCampoNombre,
              hint: l10n.accHintCampoNombre,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 20,
                        bottom: 8,
                      ),
                      child: Text(l10n.nombre),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            widget.user!.name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Semantics(
              label: l10n.accLabelCampoRolPerfil,
              hint: l10n.accHintCampoRolPerfil,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 40),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 60,
                        bottom: 8,
                      ),
                      child: Text(l10n.rol),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.user!.role),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Semantics(
              label: l10n.accLabelBtnFormCambioPass,
              hint: l10n.accHintBtnFormCambioPass,
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileFormViewmodel>().showModifyPasswordDialog(
                    context,
                    widget.user!,
                    (ProfileScreen).toString(),
                  );
                },
                child: Text(l10n.cambiarContrasena),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
