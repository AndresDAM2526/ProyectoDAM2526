import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir producto")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Form(
              key: checkForm,
              child: Column(
                children: [
                  Card(
                    child: TextFormField(
                      controller: context
                          .read<AddProductFormViewModel>()
                          .nameController,
                      validator: (value) => context
                          .read<AddProductFormViewModel>()
                          .checkName(value),
                      decoration: InputDecoration(label: Text("Nombre")),
                    ),
                  ),
                  Card(
                    child: FutureBuilder(
                      future: context.read<DatabaseService>().showTypes(),
                      builder: (context, snapshot) {
                        final types = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          key: context
                              .read<AddProductFormViewModel>()
                              .typeDropDown,
                          validator: (value) => context
                              .read<AddProductFormViewModel>()
                              .checkType(value),
                          hint: Text("Seleccione un tipo"),
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
                              context.read<AddProductFormViewModel>().type =
                                  value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Card(
                    child: FutureBuilder(
                      future: context.read<DatabaseService>().showLocations(),
                      builder: (context, snapshot) {
                        final locations = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          validator: (value) => context
                              .read<AddProductFormViewModel>()
                              .checkLocation(value),
                          key: context
                              .read<AddProductFormViewModel>()
                              .locationDropDown,
                          hint: Text("Seleccione una ubicación"),
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
                              context.read<AddProductFormViewModel>().location =
                                  value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Card(
                    child: TextFormField(
                      controller: context
                          .read<AddProductFormViewModel>()
                          .quantityController,
                      validator: (value) => context
                          .read<AddProductFormViewModel>()
                          .checkQuantity(value),
                      decoration: InputDecoration(label: Text("Cantidad")),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (checkForm.currentState!.validate()) {
                            Product newProduct = Product(
                              name: context
                                  .read<AddProductFormViewModel>()
                                  .nameController
                                  .text,
                              type: context
                                  .read<AddProductFormViewModel>()
                                  .type!,
                              location: context
                                  .read<AddProductFormViewModel>()
                                  .location!,
                              quantity: int.parse(
                                context
                                    .read<AddProductFormViewModel>()
                                    .quantityController
                                    .text,
                              ),
                            );
                            context.read<DatabaseService>().addProduct(
                              newProduct,
                            );
                            context.read<AddProductFormViewModel>().clearForm();
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text("Añadir"),
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<AddProductFormViewModel>().clearForm(),
                        child: Text("Vaciar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
