import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
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
      appBar: AppBar(
        title: Text(l10n.perfil),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(
                        "${l10n.usuario}:\t${widget.user!.username}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(
                        "${l10n.email}:\t${widget.user!.email}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(
                        "${l10n.nombre}:\t${widget.user!.name}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(
                        "${l10n.rol}:\t${widget.user!.role}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    context
                        .read<ProfileFormViewmodel>()
                        .showModifyPasswordDialog(
                          context,
                          widget.user!,
                          (ProfileScreen).toString(),
                        );
                  },
                  child: Text(l10n.cambiarContrasena),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(
                              "${l10n.usuario}:\t${widget.user!.username}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(
                              "${l10n.email}:\t${widget.user!.email}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(
                              "${l10n.nombre}:\t${widget.user!.name}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(
                              "${l10n.rol}:\t${widget.user!.role}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      context
                          .read<ProfileFormViewmodel>()
                          .showModifyPasswordDialog(
                            context,
                            widget.user!,
                            (ProfileScreen).toString(),
                          );
                    },
                    child: Text(l10n.cambiarContrasena),
                  ),
                ],
              ),
            ),
    );
  }
}
