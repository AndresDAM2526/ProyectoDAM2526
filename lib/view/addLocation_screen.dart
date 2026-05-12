import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.anadirUbicacion,
          style: TextStyle(overflow: TextOverflow.ellipsis),
          maxLines: 2,
        ),
      ),
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
                decoration: InputDecoration(label: Text(l10n.nuevaUbicacion)),
                validator: (value) => context
                    .read<AdministrationscreenViewmodel>()
                    .checkLocation(value, l10n),
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
              child: Text(l10n.anadirUbicacion),
            ),
          ],
        ),
      ),
    );
  }
}
