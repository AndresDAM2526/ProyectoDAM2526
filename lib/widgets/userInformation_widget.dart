import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserInformationWidget extends StatefulWidget {
  UserDatabase user;
  UserInformationWidget({super.key, required this.user});

  @override
  State<UserInformationWidget> createState() => _UserInformationWidgetState();
}

class _UserInformationWidgetState extends State<UserInformationWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onLongPress: () async {
        bool result = await context.read<MessagesViewmodel>().showConfirmDialog(
          context,
          MediaQuery.of(context).size.width,
          (MediaQuery.of(context).orientation == Orientation.portrait)
              ? MediaQuery.of(context).size.height / 3
              : MediaQuery.of(context).size.height / 1.5,
          l10n.confirmarBorradoUsuario,
        );
        if (result) {
          bool? deleteUser = await context.read<SupabaseService>().deleteUser(
            widget.user.idUser,
          );
          if (deleteUser == true) {
            await context.read<MessagesViewmodel>().showInformationDialog(
              context,
              MediaQuery.of(context).size.width / 2,
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height,
              l10n.usuarioEliminado,
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${l10n.nombre}: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            widget.user.name,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${l10n.usuario}: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                        Text(widget.user.username),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${l10n.email}: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            widget.user.email,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${l10n.rol}: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.user.role),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(l10n.opciones),
                      children: [
                        (context.read<ThemeViewmodel>().fontSize < 20)
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AdministrationscreenViewmodel>()
                                          .showModifyPropertiesUserDialog(
                                            context,
                                            l10n,
                                            widget.user,
                                          );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 8,
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          l10n.modificarUsuario,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AdministrationscreenViewmodel>()
                                          .showChangePasswordDialog(
                                            context,
                                            l10n,
                                            widget.user,
                                            (UserInformationWidget).toString(),
                                          );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4,
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          l10n.cambiarContrasena,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AdministrationscreenViewmodel>()
                                          .showModifyPropertiesUserDialog(
                                            context,
                                            l10n,
                                            widget.user,
                                          );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 8,
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          l10n.modificarUsuario,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<AdministrationscreenViewmodel>()
                                          .showChangePasswordDialog(
                                            context,
                                            l10n,
                                            widget.user,
                                            (UserInformationWidget).toString(),
                                          );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4,
                                        top: 8,
                                        bottom: 8,
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          l10n.cambiarContrasena,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
