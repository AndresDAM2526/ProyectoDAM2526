import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AddTypeProduct extends StatelessWidget {
  AddTypeProduct({super.key});
  final checkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir Tipo")),
      body: Form(
        key: checkForm,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: context
                    .read<AdministrationscreenViewmodel>()
                    .typeController,
                decoration: InputDecoration(label: Text("Introduzca el tipo")),
                validator: (value) => context
                    .read<AdministrationscreenViewmodel>()
                    .checkTypeProduct(value),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (checkForm.currentState!.validate()) {
                  context.read<DatabaseService>().addTypeProduct(
                    context
                        .read<AdministrationscreenViewmodel>()
                        .typeController
                        .text,
                  );
                  Navigator.pop(context, true);
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
