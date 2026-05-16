import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/register.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/historyRegisterAdministration_widget.dart';

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
          Container(
            margin: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_month),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: context.read<SupabaseService>().getHistorial(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final historial = snapshot.data;
                if (historial!.isEmpty) {
                  return Text(l10n.sinResultados);
                }
                return ListView.builder(
                  itemCount: historial.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: HistoryRegisterAdministrationWidget(
                        register: Register(
                          user: historial[index]['users']['username'],
                          name: historial[index]['users']['name'],
                          product: historial[index]['product']['product'],
                          typeRegiser:
                              historial[index]['type_register']['type_register'],
                          type: historial[index]['product']['type']['type'],
                          location:
                              historial[index]['product']['location']['location'],
                          date: context
                              .read<HistoryRegisterViewmodel>()
                              .parseDateToString(historial[index]['date']),
                          quantity: historial[index]['quantity'],
                        ),
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
