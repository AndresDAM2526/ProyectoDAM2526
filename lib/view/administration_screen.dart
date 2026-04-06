import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/view/addProduct_screen.dart';
import 'package:proyecto_dam_2526/view/modifyInventory_screen.dart';

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Administración"),),),
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductScreen()),
                  );
                  if (result == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Se ha añadido el producto")),
                    );
                  }
                },
                child: Text("Añadir producto"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Añadir usuario")),
              ElevatedButton(onPressed: () {}, child: Text("Añadir ubicación")),
              ElevatedButton(
                onPressed: () {},
                child: Text("Añadir tipo de producto"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyInventory()),
                  );
                },
                child: Text("Modificar inventario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
