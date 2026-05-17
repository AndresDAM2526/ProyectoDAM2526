import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      appBar: AppBar(
        title: Text(l10n.ubicacion),
      ),
      body: Column(
        children: [
          Expanded(
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
                      trailing: IconButton(
                        onPressed: () async {
                          bool result = await context
                              .read<SupabaseService>()
                              .deleteLocation(locations[index]['id_location']);
                          if (result) {
                            await context
                                .read<MessagesViewmodel>()
                                .showInformationDialog(
                                  context,
                                  MediaQuery.of(context).size.width / 2,
                                  MediaQuery.of(context).size.height / 2,
                                  "Ubicación eliminada",
                                );
                          }
                        },
                        icon: Icon(Icons.delete, color: AppColors.secondary),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
