import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyUserForm_viewmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModifyUserPropiertiesScreen extends StatefulWidget {
  UserDatabase user;
  ModifyUserPropiertiesScreen({super.key, required this.user});

  @override
  State<ModifyUserPropiertiesScreen> createState() =>
      _ModifyUserPropiertiesScreenState();
}

class _ModifyUserPropiertiesScreenState
    extends State<ModifyUserPropiertiesScreen> {
  final checkForm = GlobalKey<FormState>();
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.modificarUsuario)),
      body: Form(
        key: checkForm,
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: widget.user.username,
                      validator: (value) => context
                          .read<ModifyUserFormViewmodel>()
                          .checkUsername(value, l10n),
                      decoration: InputDecoration(label: Text(l10n.usuario)),
                      onSaved: (value) =>
                          context
                                  .read<ModifyUserFormViewmodel>()
                                  .usernameProperty =
                              value,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: widget.user.email,
                      validator: (value) => context
                          .read<ModifyUserFormViewmodel>()
                          .checkEmail(value, l10n),
                      decoration: InputDecoration(label: Text(l10n.email)),
                      onSaved: (value) =>
                          context
                                  .read<ModifyUserFormViewmodel>()
                                  .emailProperty =
                              value,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: widget.user.name,
                      validator: (value) => context
                          .read<ModifyUserFormViewmodel>()
                          .checkName(value, l10n),
                      decoration: InputDecoration(label: Text(l10n.nombre)),
                      onSaved: (value) =>
                          context.read<ModifyUserFormViewmodel>().nameProperty =
                              value,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Consumer<SupabaseService>(
                      builder: (context, values, child) {
                        final roles = values.roles;
                        return DropdownButtonFormField<String>(
                          initialValue: widget.user.role,
                          decoration: InputDecoration(label: Text(l10n.rol)),
                          validator: (value) => context
                              .read<ModifyUserFormViewmodel>()
                              .checkRole(value, l10n),
                          items: roles
                              .map(
                                (role) => DropdownMenuItem<String>(
                                  value: role['role'],
                                  child: Text(role['role']),
                                ),
                              )
                              .toList(),
                          onSaved: (value) =>
                              context
                                      .read<ModifyUserFormViewmodel>()
                                      .roleProperty =
                                  value,
                          onChanged: (value) =>
                              context
                                      .read<ModifyUserFormViewmodel>()
                                      .roleProperty =
                                  value,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (checkForm.currentState!.validate()) {
                        checkForm.currentState!.save();
                        bool? modified = await context
                            .read<SupabaseService>()
                            .updateUser(
                              UserDatabase(
                                idUser: widget.user.idUser,
                                username: context
                                    .read<ModifyUserFormViewmodel>()
                                    .usernameProperty!,
                                email: context
                                    .read<ModifyUserFormViewmodel>()
                                    .emailProperty!,
                                name: context
                                    .read<ModifyUserFormViewmodel>()
                                    .nameProperty!,
                                role: context
                                    .read<ModifyUserFormViewmodel>()
                                    .roleProperty!,
                                firstLogin: false,
                              ),
                              context,
                            );
                        if (modified == true) {
                          Navigator.pop(context, true);
                        } else {
                          Navigator.pop(context, false);
                        }
                      }
                    },
                    child: Text(l10n.enviar),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.user.username,
                        validator: (value) => context
                            .read<ModifyUserFormViewmodel>()
                            .checkUsername(value, l10n),
                        decoration: InputDecoration(label: Text(l10n.usuario)),
                        onSaved: (value) =>
                            context
                                    .read<ModifyUserFormViewmodel>()
                                    .usernameProperty =
                                value,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        initialValue: widget.user.name,
                        validator: (value) => context
                            .read<ModifyUserFormViewmodel>()
                            .checkName(value, l10n),
                        decoration: InputDecoration(label: Text(l10n.nombre)),
                        onSaved: (value) =>
                            context
                                    .read<ModifyUserFormViewmodel>()
                                    .nameProperty =
                                value,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: context.read<DatabaseService>().showRoles(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(l10n.errorCargaDatos);
                          }
                          final roles = snapshot.data ?? [];
                          return DropdownButtonFormField(
                            initialValue: widget.user.role,
                            decoration: InputDecoration(label: Text(l10n.rol)),
                            validator: (value) => context
                                .read<ModifyUserFormViewmodel>()
                                .checkRole(value, l10n),
                            items: roles
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                            onSaved: (value) =>
                                context
                                        .read<ModifyUserFormViewmodel>()
                                        .roleProperty =
                                    value,
                            onChanged: (value) =>
                                context
                                        .read<ModifyUserFormViewmodel>()
                                        .roleProperty =
                                    value,
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (checkForm.currentState!.validate()) {
                          checkForm.currentState!.save();
                          context.read<DatabaseService>().updateUser(
                            UserDatabase(
                              idUser: widget.user.idUser,
                              email: context
                                  .read<ModifyUserFormViewmodel>()
                                  .emailProperty!,
                              name: context
                                  .read<ModifyUserFormViewmodel>()
                                  .nameProperty!,
                              username: context
                                  .read<ModifyUserFormViewmodel>()
                                  .usernameProperty!,
                              role: context
                                  .read<ModifyUserFormViewmodel>()
                                  .roleProperty!,
                              firstLogin: false,
                            ),
                          );
                          context.read<ModifyUserFormViewmodel>().clearForm();
                          Navigator.pop(context, true);
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
