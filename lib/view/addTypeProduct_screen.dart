import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddTypeProduct extends StatefulWidget {
  AddTypeProduct({super.key});

  @override
  State<AddTypeProduct> createState() => _AddTypeProductState();
}

class _AddTypeProductState extends State<AddTypeProduct> {
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
              onPressed: () async {
                if (checkForm.currentState!.validate()) {
                  bool added = await context
                      .read<SupabaseService>()
                      .addTypeProduct(
                        context
                            .read<AdministrationscreenViewmodel>()
                            .typeController
                            .text,
                      );
                  if (added == true) {
                    Navigator.pop(context, true);
                  } else {
                    print("Error al añadir el tipo");
                  }
                }
              },
              child: Text("Añadir tipo"),
            ),
          ],
        ),
      ),
    );
  }
}
