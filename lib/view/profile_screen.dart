import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Perfil")),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          label: Text(
                            "Usuario:\t${widget.user!.username}",
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
                            "Nombre:\t${widget.user!.name}",
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
                            "Rol:\t${widget.user!.role}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileFormViewmodel>().showModifyPasswordDialog(
                context,
                widget.user!,
                (ProfileScreen).toString(),
              );
            },
            child: Text("Cambiar contraseña"),
          ),
        ],
      ),
    );
  }
}
