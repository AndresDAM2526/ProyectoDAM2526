import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AddlocationScreen extends StatefulWidget {
  AddlocationScreen({super.key});

  @override
  State<AddlocationScreen> createState() => _AddlocationScreenState();
}

class _AddlocationScreenState extends State<AddlocationScreen> {
  final checkForm = GlobalKey<FormState>();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Form(
        key: checkForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: l10n.accLabelCampoUbicacion,
              hint: l10n.accHintCampoUbicacion,
              child: Container(
                margin: EdgeInsets.all(20),
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
            ),
            Semantics(
              label: l10n.accLabelBtnEnviar,
              hint: l10n.accHintBtnEnviar,
              child: Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
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
                        await Future.delayed(Duration(milliseconds: 100));
                        if (mounted) {
                          Navigator.pop(context, true);
                        }
                      }
                    }
                  },
                  child: Text(l10n.anadirUbicacion),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
