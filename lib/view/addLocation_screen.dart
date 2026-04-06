import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AddlocationScreen extends StatelessWidget {
  AddlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checkForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: checkForm,
        child: Column(
          children: [
            TextFormField(
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
            ElevatedButton(
              onPressed: () {
                if (checkForm.currentState!.validate()) {
                  context.read<DatabaseService>().addLocation(
                    context
                        .read<AdministrationscreenViewmodel>()
                        .locationController
                        .text,
                  );
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
