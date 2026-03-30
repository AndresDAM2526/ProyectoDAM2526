import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/Product.dart';

class AddproductScreen extends StatefulWidget {
  List<Product> list;
  AddproductScreen({super.key, required this.list});

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(label: Text("Nombre")),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: typeController,
                      decoration: InputDecoration(label: Text("Tipo")),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(label: Text("Ubicación")),
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text("Cantidad")),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.list.add(
                    Product(
                      name: nameController.text,
                      type: typeController.text,
                      location: locationController.text,
                      quantity: int.parse(quantityController.text),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Se ha añadido el producto")),
                  );
                  clearForm();
                },
                child: Text("Añadir"),
              ),
              ElevatedButton(
                onPressed: () => clearForm(),
                child: Text("Vaciar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void clearForm() {
    nameController.clear();
    typeController.clear();
    locationController.clear();
  }
}
