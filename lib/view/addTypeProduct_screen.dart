import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';

class AddTypeProduct extends StatefulWidget {
  AddTypeProduct({super.key});

  @override
  State<AddTypeProduct> createState() => _AddTypeProductState();
}

class _AddTypeProductState extends State<AddTypeProduct> {
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
          children: [
            Semantics(
              label: l10n.accLabelCampoTipoProducto,
              hint: l10n.accHintCampoTipoProducto,
              child: Container(
                margin: EdgeInsets.all(20),
                child: TextFormField(
                  controller: context
                      .read<AdministrationscreenViewmodel>()
                      .typeController,
                  decoration: InputDecoration(label: Text(l10n.introducirTipo)),
                  validator: (value) => context
                      .read<AdministrationscreenViewmodel>()
                      .checkTypeProduct(value, l10n),
                ),
              ),
            ),
            Semantics(
              label: l10n.accLabelBtnEnviar,
              hint: l10n.accHintBtnEnviar,
              child: ElevatedButton(
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
                    if (added == true && mounted) {
                      context
                          .read<AdministrationscreenViewmodel>()
                          .typeController
                          .clear();
                      await Future.delayed(Duration(milliseconds: 100));
                      if (mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  }
                },
                child: Text(l10n.anadirTipo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
