import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tipo)),
      body: Column(
        children: [
          Semantics(
            label:l10n.accLabelListadoTiposProducto,
            hint: l10n.accHintListadoTiposProducto,
            child: Expanded(
              child: Consumer<SupabaseService>(
                builder: (context, value, child) {
                  final types = value.types;
                  if (types.isEmpty) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: types.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(types[index]['type']),
                        trailing: Semantics(
                          label: l10n.accLabelBtnBorrarElemento,
                          hint: l10n.accHintBtnBorrarElemento,
                          child: IconButton(
                            onPressed: () async {
                              bool result = await context
                                  .read<SupabaseService>()
                                  .deleteType(
                                    context,
                                    types[index]['id_type'],
                                    l10n,
                                  );
                              if (result) {
                                context
                                    .read<MessagesViewmodel>()
                                    .showInformationDialog(
                                      context,
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height / 3,
                                      l10n.tipoEliminado,
                                    );
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
