import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final checkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(l10n.anadirProducto),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: checkForm,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: context
                        .read<AddProductFormViewModel>()
                        .nameController,
                    validator: (value) => context
                        .read<AddProductFormViewModel>()
                        .checkName(value, l10n),
                    decoration: InputDecoration(
                      label: Text(l10n.nombre),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                ),
                Consumer<SupabaseService>(
                  builder: (context, values, child) {
                    final types = values.types;
                    if (types.isEmpty) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: DropdownButtonFormField<String>(
                        validator: (value) => context
                            .read<AddProductFormViewModel>()
                            .checkType(value, l10n),
                        key: context
                            .read<AddProductFormViewModel>()
                            .typeDropDown,
                        initialValue: context
                            .read<AddProductFormViewModel>()
                            .type,
                        decoration: InputDecoration(
                          label: Text(l10n.tipo),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        hint: Text(l10n.seleccionarTipo),
                        items: types
                            .map(
                              (type) => DropdownMenuItem<String>(
                                value: type['type'],
                                child: Text(type['type']),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          context.read<AddProductFormViewModel>().type = value;
                        },
                      ),
                    );
                  },
                ),
                Consumer<SupabaseService>(
                  builder: (context, values, child) {
                    final locations = values.locations;
                    if (locations.isEmpty) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: DropdownButtonFormField<String>(
                        validator: (value) => context
                            .read<AddProductFormViewModel>()
                            .checkLocation(value, l10n),
                        initialValue: context
                            .read<AddProductFormViewModel>()
                            .location,
                        key: context
                            .read<AddProductFormViewModel>()
                            .locationDropDown,
                        decoration: InputDecoration(
                          label: Text(l10n.ubicacion),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        hint: Text(l10n.seleccionarUbicacion),
                        items: locations
                            .map(
                              (location) => DropdownMenuItem<String>(
                                value: location['location'],
                                child: Text(location['location']),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          context.read<AddProductFormViewModel>().location =
                              value;
                        },
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    controller: context
                        .read<AddProductFormViewModel>()
                        .quantityController,
                    validator: (value) => context
                        .read<AddProductFormViewModel>()
                        .checkQuantity(value, l10n),
                    decoration: InputDecoration(
                      label: Text(l10n.cantidad),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                    
                      onPressed: () async {
                        if (checkForm.currentState!.validate()) {
                          Product newProduct = Product(
                            name: context
                                .read<AddProductFormViewModel>()
                                .nameController
                                .text,
                            type: context.read<AddProductFormViewModel>().type!,
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
                          bool added = await context
                              .read<SupabaseService>()
                              .addProduct(newProduct);
                          print(added);
                          if (added == true) {
                            context.read<AddProductFormViewModel>().clearForm();
                            Navigator.pop(context, true);
                          }
                        }
                      },
                      child: Text(l10n.anadir),
                    ),
                    ElevatedButton(
                    
                      onPressed: () =>
                          context.read<AddProductFormViewModel>().clearForm(),
                      child: Text(l10n.vaciar),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
