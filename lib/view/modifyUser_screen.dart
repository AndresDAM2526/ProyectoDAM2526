import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/widgets/userInformation_widget.dart';

class ModifyUserScreen extends StatefulWidget {
  const ModifyUserScreen({super.key});

  @override
  State<ModifyUserScreen> createState() => _ModifyUserScreenState();
}

class _ModifyUserScreenState extends State<ModifyUserScreen> {
  String? search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modificar usuario")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                label: Text("Introduzca el usuario o nombre"),
              ),
              onSubmitted: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          search!.isEmpty
              ? Text("")
              : Expanded(
                  child: FutureBuilder(
                    future: context
                        .read<DatabaseService>()
                        .getUserByNameOrUsername(search),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("No se han encontrado resultados");
                      }
                      final foundUsers = snapshot.data;
                      return ListView.builder(
                        itemCount: foundUsers!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: UserInformationWidget(
                              user: UserDatabase(
                                idUser: foundUsers[index]['idUser'],
                                name: foundUsers[index]['name'],
                                username: foundUsers[index]['username'],
                                role: foundUsers[index]['role'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
