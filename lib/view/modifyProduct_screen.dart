import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
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
                    child: Consumer<SupabaseService>(
                      builder: (context, value, child) {
                        final types = value.types;
                        if (types.isEmpty) {
                          return CircularProgressIndicator();
                        }
                        return DropdownButtonFormField<String>(
                          initialValue: widget.product.type,
                          hint: Text("Seleccione el tipo"),
                          validator: (value) => context
                              .read<ModifyProductFormViewmodel>()
                              .checkType(value),
                          items: types
                              .map(
                                (type) => DropdownMenuItem<String>(
                                  value: type['type'],
                                  child: Text(type['type']),
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
                    child: Consumer<SupabaseService>(
                      builder: (context, value, child) {
                        final locations = value.locations;
                        if (locations.isEmpty) {
                          return CircularProgressIndicator();
                        }
                        return DropdownButtonFormField<String>(
                          initialValue: widget.product.location,
                          hint: Text("Seleccione el tipo"),
                          validator: (value) => context
                              .read<ModifyProductFormViewmodel>()
                              .checkType(value),
                          items: locations
                              .map(
                                (location) => DropdownMenuItem<String>(
                                  value: location['location'],
                                  child: Text(location['location']),
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
                      keyboardType: TextInputType.numberWithOptions(),
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
                        onPressed: () async {
                          if (checkForm.currentState!.validate()) {
                            checkForm.currentState!.save();

                            bool updated = await context
                                .read<SupabaseService>()
                                .modifyProduct(
                                  DatabaseProduct(
                                    idProduct: widget.product.idProduct,
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
                                );
                            if (updated == true) {
                              Navigator.pop(context, true);
                            }
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
