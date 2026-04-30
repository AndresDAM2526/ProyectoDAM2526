import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/NewUser.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String? selectedRol;
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir usuario")),
      body: Form(
        key: checkForm,
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .nameController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkName(value),
                        decoration: InputDecoration(label: Text("Nombre")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .userController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkUser(value),
                        decoration: InputDecoration(label: Text("Usuario")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .emailController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkEmail(value),
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .passwordController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkPassword(value),
                        decoration: InputDecoration(label: Text("Contraseña")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Consumer<SupabaseService>(
                        builder: (context, values, child) {
                          final roles = values.roles;
                          return DropdownButtonFormField<String>(
                            validator: (value) => context
                                .read<AdduserFormViewmodel>()
                                .checkRole(value),
                            decoration: InputDecoration(label: Text("Rol")),
                            items: roles
                                .map(
                                  (role) => DropdownMenuItem<String>(
                                    value: role['role'],
                                    child: Text(role['role']),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                context.read<AdduserFormViewmodel>().role =
                                    value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (checkForm.currentState!.validate()) {
                          int? idRole =
                              await context
                                  .read<SupabaseService>()
                                  .getIdRoleFromNameRole(
                                    context.read<AdduserFormViewmodel>().role!,
                                  ) ??
                              2;
                          bool? added = await context
                              .read<AuthService>()
                              .createNewUser(
                                NewUser(
                                  email: context
                                      .read<AdduserFormViewmodel>()
                                      .emailController
                                      .text,
                                  name: context
                                      .read<AdduserFormViewmodel>()
                                      .nameController
                                      .text,
                                  username: context
                                      .read<AdduserFormViewmodel>()
                                      .userController
                                      .text,
                                  password: context
                                      .read<AdduserFormViewmodel>()
                                      .passwordController
                                      .text,
                                  idRole: idRole,
                                ),
                                context,
                              );
                          if (added == true) {
                            context.read<AdduserFormViewmodel>().clearForm();
                            Navigator.pop(context, true);
                          }
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      child: Text("Enviar"),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .nameController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkName(value),
                        decoration: InputDecoration(label: Text("Nombre")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .userController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkUser(value),
                        decoration: InputDecoration(label: Text("Usuario")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .emailController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkEmail(value),
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: context
                            .read<AdduserFormViewmodel>()
                            .passwordController,
                        validator: (value) => context
                            .read<AdduserFormViewmodel>()
                            .checkPassword(value),
                        decoration: InputDecoration(label: Text("Contraseña")),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: context.read<DatabaseService>().showRoles(),
                        builder: (context, snapshot) {
                          final roles = snapshot.data ?? [];
                          return DropdownButtonFormField(
                            validator: (value) => context
                                .read<AdduserFormViewmodel>()
                                .checkRole(value),
                            decoration: InputDecoration(label: Text("Rol")),
                            items: roles
                                .map(
                                  (rol) => DropdownMenuItem(
                                    value: rol,
                                    child: Text(rol),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                context.read<AdduserFormViewmodel>().role =
                                    value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (checkForm.currentState!.validate()) {
                          context.read<DatabaseService>().addUser(
                            User(
                              email: context
                                  .read<AdduserFormViewmodel>()
                                  .emailController
                                  .text,
                              name: context
                                  .read<AdduserFormViewmodel>()
                                  .nameController
                                  .text,
                              username: context
                                  .read<AdduserFormViewmodel>()
                                  .userController
                                  .text,
                              password: context
                                  .read<AdduserFormViewmodel>()
                                  .passwordController
                                  .text,
                              role: context.read<AdduserFormViewmodel>().role!,
                            ),
                          );
                          context.read<AdduserFormViewmodel>().clearForm();
                          Navigator.pop(context, true);
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      child: Text("Enviar"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
