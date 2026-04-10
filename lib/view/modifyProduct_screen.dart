import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';

class ModifyProductScreen extends StatefulWidget {
  DatabaseProduct product;
  ModifyProductScreen({super.key, required this.product});

  @override
  State<ModifyProductScreen> createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {
  final checkForm = GlobalKey<FormState>();
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
            Form(
              key: checkForm,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) => context
                          .read<ModifyProductFormViewmodel>()
                          .checkName(value),
                      initialValue: widget.product.name,
                      decoration: InputDecoration(
                        label: Text("Introduzca el nombre"),
                      ),
                      onSaved: (newValue) =>
                          context
                                  .read<ModifyProductFormViewmodel>()
                                  .nameProperty =
                              newValue,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: context.read<DatabaseService>().showTypes(),
                      builder: (context, snapshot) {
                        final types = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          initialValue: widget.product.type,
                          hint: Text("Seleccione el tipo"),
                          validator: (value) => context
                              .read<ModifyProductFormViewmodel>()
                              .checkType(value),
                          items: types
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                          onSaved: (value) =>
                              context
                                      .read<ModifyProductFormViewmodel>()
                                      .typeProperty =
                                  value,
                          onChanged: (value) =>
                              context
                                      .read<ModifyProductFormViewmodel>()
                                      .typeProperty =
                                  value,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder(
                      future: context.read<DatabaseService>().showLocations(),
                      builder: (context, snapshot) {
                        final locations = snapshot.data ?? [];
                        return DropdownButtonFormField(
                          initialValue: widget.product.location,
                          hint: Text("Seleccione la ubicación"),
                          validator: (value) => context
                              .read<ModifyProductFormViewmodel>()
                              .checkLocation(value),
                          items: locations
                              .map(
                                (location) => DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                ),
                              )
                              .toList(),
                          onSaved: (value) =>
                              context
                                      .read<ModifyProductFormViewmodel>()
                                      .locationProperty =
                                  value,
                          onChanged: (value) =>
                              context
                                      .read<ModifyProductFormViewmodel>()
                                      .locationProperty =
                                  value,
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) => context
                          .read<ModifyProductFormViewmodel>()
                          .checkQuantity(value),
                      initialValue: widget.product.quantity.toString(),
                      decoration: InputDecoration(
                        label: Text("Introduzca la cantidad"),
                      ),
                      onSaved: (newValue) =>
                          context.read<ModifyProductFormViewmodel>().quantity =
                              newValue,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (checkForm.currentState!.validate()) {
                            checkForm.currentState!.save();
                            context.read<DatabaseService>().modifyProduct(
                              Product(
                                name: context
                                    .read<ModifyProductFormViewmodel>()
                                    .nameProperty!,
                                type: context
                                    .read<ModifyProductFormViewmodel>()
                                    .typeProperty!,
                                location: context
                                    .read<ModifyProductFormViewmodel>()
                                    .locationProperty!,
                                quantity: int.parse(
                                  context
                                      .read<ModifyProductFormViewmodel>()
                                      .quantity!,
                                ),
                              ),
                              widget.product.idProduct,
                            );
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text("Enviar"),
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
