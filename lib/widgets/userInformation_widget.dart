import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
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
    final l10n=AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        color: Colors.greenAccent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${l10n.usuario}: ${widget.user.username}"),
                  Text("${l10n.nombre}: ${widget.user.name}"),
                  Text("${l10n.rol}: ${widget.user.role}"),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .showModifyPropertiesUserDialog(context,l10n, widget.user);
                  },
                  icon: Icon(Icons.update),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .showChangePasswordDialog(
                          context,
                          l10n,
                          widget.user,
                          (UserInformationWidget).toString(),
                        );
                  },
                  icon: Icon(Icons.password),
                ),
                IconButton(
                  onPressed: () async {
                    bool result = await context
                        .read<MessagesViewmodel>()
                        .showConfirmDialog(
                          context,
                          MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height / 2,
                          l10n.confirmarBorradoUsuario,
                        );
                    if (result) {
                      bool? deleteUser = await context
                          .read<SupabaseService>()
                          .deleteUser(widget.user.idUser);
                      if (deleteUser == true) {
                        await context
                            .read<MessagesViewmodel>()
                            .showInformationDialog(
                              context,
                              MediaQuery.of(context).size.width / 2,
                              MediaQuery.of(context).size.height / 3,
                              l10n.usuarioEliminado,
                            );
                      }
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
