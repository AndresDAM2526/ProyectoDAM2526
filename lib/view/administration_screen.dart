import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/view/addProduct_screen.dart';
import 'package:proyecto_dam_2526/view/addUser_screen.dart';
import 'package:proyecto_dam_2526/view/modifyInventory_screen.dart';
import 'package:proyecto_dam_2526/view/modifyUser_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Administración"))),
      body: Column(
        children: [
          Text("Usuarios"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUserScreen(),
                      ),
                    );
                    if (result == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Se ha añadido el usuario")),
                      );
                    }
                  },
                  child: Text("Añadir usuario"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModifyUserScreen(),
                    ),
                  );
                },
                child: Text("Modificar usuario"),
              ),
            ],
          ),

          Text("Inventario"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductScreen(),
                      ),
                    );
                    if (result == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Se ha añadido el producto")),
                      );
                    }
                  },
                  child: Text("Añadir producto"),
                ),
              ),
          
              ElevatedButton(
                onPressed: () {
                  context
                      .read<AdministrationscreenViewmodel>()
                      .showAddLocationDialog(context);
                },
                child: Text("Añadir ubicación"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .showAddTypeProductDialog(context);
                  },
                  child: Text("Añadir tipo"),
                ),
              ),
          
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModifyInventory(),
                    ),
                  );
                },
                child: Text("Modificar inventario"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
