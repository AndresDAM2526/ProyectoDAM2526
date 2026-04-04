import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/DatabaseProduct.dart';
import 'package:proyecto_dam_2526/model/Product.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/searchProductFrom_viewmodel.dart';

class ModifyProductScreen extends StatefulWidget {
  DatabaseProduct product;
  ModifyProductScreen({super.key, required this.product});

  @override
  State<ModifyProductScreen> createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {
  final checkForm = GlobalKey<FormState>();
  List<Widget> elements = [
    Text("Nombre"),
    Text("Tipo"),
    Text("Ubicación"),
    Text("Cantidad"),
    Text("Todo"),
  ];
  final List<bool> _selectedItem = [false, false, false, false, false];
  String? name = "";
  String? selectedType;
  String? selectedLocation = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Modificar producto"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Seleccione que desea modificar"),
            Center(
              child: ToggleButtons(
                isSelected: _selectedItem,
                children: elements,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _selectedItem.length; i++) {
                      _selectedItem[i] = (i == index);
                    }
                  });
                },
              ),
            ),
            _selectedItem[0]
                ? Form(
                    key: checkForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: context
                                .read<ModifyProductformViewmodel>()
                                .nameController,
                            validator: (value) => context
                                .read<ModifyProductformViewmodel>()
                                .checkName(value),
                            decoration: InputDecoration(
                              label: Text("Introduzca el nuevo nombre"),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (checkForm.currentState!.validate()) {
                                  await context
                                      .read<DatabaseService>()
                                      .modifyNameProduct(
                                        widget.product.idProduct,
                                        context
                                            .read<ModifyProductformViewmodel>()
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
                            ElevatedButton(
                              onPressed: () => context
                                  .read<ModifyProductformViewmodel>()
                                  .clearForm(),
                              child: Text("Vaciar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : _selectedItem[1]
                ? Form(
                    key: checkForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: context.read<DatabaseService>().showTypes(),
                            builder: (context, snapshot) {
                              final types = snapshot.data ?? [];
                              return DropdownButtonFormField(
                                hint: Text("Seleccione el tipo"),
                                validator: (value) => context
                                    .read<ModifyProductformViewmodel>()
                                    .checkType(value),
                                items: types
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (checkForm.currentState!.validate()) {
                                  context
                                      .read<DatabaseService>()
                                      .modifyTypeProduct(
                                        widget.product.idProduct,
                                        selectedType!,
                                      );
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pop(context, false);
                                }
                              },
                              child: Text("Enviar"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  context
                                      .read<ModifyProductformViewmodel>()
                                      .clearForm();
                                  selectedType = null;
                                });
                              },
                              child: Text("Vaciar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : _selectedItem[2]
                ? Form(
                    key: checkForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: context
                                .read<DatabaseService>()
                                .showLocations(),
                            builder: (context, snapshot) {
                              final locations = snapshot.data ?? [];
                              return DropdownButtonFormField(
                                hint: Text("Seleccione la ubicación"),
                                validator: (value) => context
                                    .read<ModifyProductformViewmodel>()
                                    .checkLocation(value),
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
                                    selectedLocation = value!;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (checkForm.currentState!.validate()) {
                                  context
                                      .read<DatabaseService>()
                                      .modifyLocationProduct(
                                        widget.product.idProduct,
                                        selectedLocation!,
                                      );
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pop(context, false);
                                }
                              },
                              child: Text("Enviar"),
                            ),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<ModifyProductformViewmodel>()
                                  .clearForm(),
                              child: Text("Vaciar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : _selectedItem[3]
                ? Form(
                    key: checkForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) => context
                                .read<ModifyProductformViewmodel>()
                                .checkQuantity(value),
                            controller: context
                                .read<ModifyProductformViewmodel>()
                                .quantityController,
                            decoration: InputDecoration(
                              label: Text("Introduzca la nueva cantidad "),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (checkForm.currentState!.validate()) {
                                  context
                                      .read<DatabaseService>()
                                      .modifyQuantiyProduct(
                                        widget.product.idProduct,
                                        int.parse(
                                          context
                                              .read<
                                                ModifyProductformViewmodel
                                              >()
                                              .quantityController
                                              .text,
                                        ),
                                      );
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pop(context, false);
                                }
                              },
                              child: Text("Enviar"),
                            ),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<ModifyProductformViewmodel>()
                                  .clearForm(),
                              child: Text("Vaciar"),
                            ),
                          ],
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
                          child: TextFormField(
                            validator: (value) => context
                                .read<ModifyProductformViewmodel>()
                                .checkName(value),
                            controller: context
                                .read<ModifyProductformViewmodel>()
                                .nameController,
                            decoration: InputDecoration(
                              label: Text("Introduzca el nombre"),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: context.read<DatabaseService>().showTypes(),
                            builder: (context, snapshot) {
                              final types = snapshot.data ?? [];
                              return DropdownButtonFormField(
                                hint: Text("Seleccione el tipo"),
                                validator: (value) => context
                                    .read<ModifyProductformViewmodel>()
                                    .checkType(value),
                                items: types
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: context
                                .read<DatabaseService>()
                                .showLocations(),
                            builder: (context, snapshot) {
                              final locations = snapshot.data ?? [];
                              return DropdownButtonFormField(
                                hint: Text("Seleccione la ubicación"),
                                validator: (value) => context
                                    .read<ModifyProductformViewmodel>()
                                    .checkLocation(value),
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
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) => context
                                .read<ModifyProductformViewmodel>()
                                .checkQuantity(value),
                            controller: context
                                .read<ModifyProductformViewmodel>()
                                .quantityController,
                            decoration: InputDecoration(
                              label: Text("Introduzca la cantidad"),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (checkForm.currentState!.validate()) {
                                  context.read<DatabaseService>().modifyProduct(
                                    Product(
                                      name: context
                                          .read<ModifyProductformViewmodel>()
                                          .nameController
                                          .text,
                                      type: selectedType!,
                                      location: selectedLocation!,
                                      quantity: int.parse(
                                        context
                                            .read<ModifyProductformViewmodel>()
                                            .quantityController
                                            .text,
                                      ),
                                    ),
                                    widget.product.idProduct,
                                  );
                                  Navigator.pop(context,true);
                                } else {
                                  
                                  Navigator.pop(context, false);
                                }
                              },
                              child: Text("Enviar"),
                            ),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<ModifyProductformViewmodel>()
                                  .clearForm(),
                              child: Text("Vaciar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
