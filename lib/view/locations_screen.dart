import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.ubicacion)),
      body: Column(
        children: [
          Expanded(
            child: Semantics(
              label: l10n.accLabelListadoUbicaciones,
              hint: l10n.accHintListadoUbicaciones,
              child: Consumer<SupabaseService>(
                builder: (context, value, child) {
                  final locations = value.locations;
                  if (locations.isEmpty) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(locations[index]['location']),
                        trailing: Semantics(
                          label: l10n.accLabelBtnBorrarUbicacion,
                          hint: l10n.accHintBtnBorrarUbicacion,
                          child: IconButton(
                            onPressed: () async {
                              bool result = await context
                                  .read<SupabaseService>()
                                  .deleteLocation(
                                    locations[index]['id_location'],
                                    context,
                                    l10n,
                                  );
                              if (result) {
                                await context
                                    .read<MessagesViewmodel>()
                                    .showInformationDialog(
                                      context,
                                      MediaQuery.of(context).size.width,
                                      (MediaQuery.of(context).orientation ==
                                              Orientation.portrait)
                                          ? MediaQuery.of(context).size.height *
                                                0.3
                                          : MediaQuery.of(context).size.height *
                                                0.6,
                                      l10n.ubicacionBorrada,
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
