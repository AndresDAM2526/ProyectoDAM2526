import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class ModifyUserPropiertiesScreen extends StatefulWidget {
  UserDatabase? user;
  ModifyUserPropiertiesScreen({super.key, required this.user});

  @override
  State<ModifyUserPropiertiesScreen> createState() =>
      _ModifyUserPropiertiesScreenState();
}

class _ModifyUserPropiertiesScreenState
    extends State<ModifyUserPropiertiesScreen> {
  final checkForm = GlobalKey<FormState>();
  List<Widget> elements = [Text("Usuario"), Text("Nombre"), Text("Rol")];
  final List<bool> _selected = [false, false, false];
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modificar usuario")),
      body: Column(
        children: [
          Center(
            child: ToggleButtons(
              isSelected: _selected,
              children: elements,
              onPressed: (index) {
                setState(() {
                  for (int i = 0; i < elements.length; i++) {
                    _selected[i] = (i == index);
                  }
                });
              },
            ),
          ),
          _selected[0]
              ? Form(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: context
                              .read<AdministrationscreenViewmodel>()
                              .userController,
                          validator: (value) => context
                              .read<AdministrationscreenViewmodel>()
                              .checkName(value),
                          decoration: InputDecoration(label: Text("Usuario")),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (checkForm.currentState!.validate()) {
                            context.read<DatabaseService>().updateName(
                              widget.user!.idUser,
                              context
                                  .read<AdministrationscreenViewmodel>()
                                  .userController
                                  .text,
                            );
                            Navigator.pop(context, true);
                          } else {
                            Navigator.pop(context, false);
                          }
                        },
                        child: Text("Enviar"),
                      ),
                    ],
                  ),
                )
              : _selected[1]
              ? Form(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: context
                              .read<AdministrationscreenViewmodel>()
                              .nameController,
                          validator: (value) => context
                              .read<AdministrationscreenViewmodel>()
                              .checkName(value),
                          decoration: InputDecoration(label: Text("Nombre")),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (checkForm.currentState!.validate()) {
                            context.read<DatabaseService>().updateName(
                              widget.user!.idUser,
                              context
                                  .read<AdministrationscreenViewmodel>()
                                  .nameController
                                  .text,
                            );
                            Navigator.pop(context, true);
                          } else {
                            Navigator.pop(context, false);
                          }
                        },
                        child: Text("Enviar"),
                      ),
                    ],
                  ),
                )
              : Form(
                  key: checkForm,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: FutureBuilder(
                          future: context.read<DatabaseService>().showRoles(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("No se han podido obtener los datos");
                            } else if (!snapshot.hasData) {
                              return Text("Error al obtener los roles");
                            }
                            final roles = snapshot.data;
                            return DropdownButtonFormField(
                              decoration: InputDecoration(label: Text("Rol")),
                              validator: (value) => context
                                  .read<AdministrationscreenViewmodel>()
                                  .checkRole(value),
                              items: roles!
                                  .map(
                                    (role) => DropdownMenuItem(
                                      value: role,
                                      child: Text(role),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (checkForm.currentState!.validate()) {
                            print("validado");
                          }
                        },
                        child: Text("Enviar"),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
