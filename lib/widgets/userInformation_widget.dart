import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class UserInformationWidget extends StatelessWidget {
  UserDatabase user;
  UserInformationWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
                  Text("Usuario: ${user.username}"),
                  Text("Nombre: ${user.name}"),
                  Text("Rol: ${user.role}"),
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
                        .showModifyPropertiesUserDialog(context, user);
                  },
                  icon: Icon(Icons.update),
                ),
                IconButton(
                  onPressed: () {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .showChangePasswordDialog(context, user);
                  },
                  icon: Icon(Icons.password),
                ),
                IconButton(
                  onPressed: () {
                    context.read<DatabaseService>().deleteUser(user.idUser);
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
