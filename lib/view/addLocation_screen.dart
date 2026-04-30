import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AddlocationScreen extends StatefulWidget {
  AddlocationScreen({super.key});

  @override
  State<AddlocationScreen> createState() => _AddlocationScreenState();
}

class _AddlocationScreenState extends State<AddlocationScreen> {
  final checkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir ubicación")),
      body: Form(
        key: checkForm,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: context
                    .read<AdministrationscreenViewmodel>()
                    .locationController,
                decoration: InputDecoration(
                  label: Text("Introduzca la ubicación"),
                ),
                validator: (value) => context
                    .read<AdministrationscreenViewmodel>()
                    .checkLocation(value!),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (checkForm.currentState!.validate()) {
                  bool added = await context
                      .read<SupabaseService>()
                      .addLocation(
                        context
                            .read<AdministrationscreenViewmodel>()
                            .locationController
                            .text,
                      );
                  if (added == true) {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .clearLocation();
                    Navigator.pop(context, true);
                  }
                }
              },
              child: Text("Añadir ubicación"),
            ),
          ],
        ),
      ),
    );
  }
}
