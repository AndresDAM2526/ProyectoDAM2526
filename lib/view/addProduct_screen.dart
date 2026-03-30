import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/Product.dart';
import 'package:proyecto_dam_2526/viewmodel/database_viewmodel.dart';

class AddproductScreen extends StatefulWidget {
  AddproductScreen({super.key});

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String? selectedCategory;
  String? selectedLocation;
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
                    child: FutureBuilder(
                      future: context.read<DatabaseViewmodel>().showTypes(),
                      builder: (context, snapshot) {
                        final types = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          items: types
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type.toString(),
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Card(
                    child: FutureBuilder(
                      future: context.read<DatabaseViewmodel>().showLocations(),
                      builder: (context, snapshot) {
                        final locations = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          items: locations
                              .map(
                                (location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedLocation = value;
                            });
                          },
                        );
                      },
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
