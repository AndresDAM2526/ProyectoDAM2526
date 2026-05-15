import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(l10n.historial),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: context.read<SupabaseService>().getHistorial(),
              builder: (context, snapshot) {
                final historial = snapshot.data;
                if (historial!.isEmpty) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${historial[index]['product']['product']}--${historial[index]['users']['username']}--${historial[index]['type_register']['type_register']}--${historial[index]['date']}",
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
