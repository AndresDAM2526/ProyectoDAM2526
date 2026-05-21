import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/register.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/historyRegisterAdministration_widget.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen> {
  String search = "";
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(l10n.historial)),
        body: Column(
          children: [
            Semantics(
              label: l10n.accLabelCampoBuscarRegistro,
              hint: l10n.accHintCampoBuscarRegistro,
              child: Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      search = value.trim();
                    });
                  },
                ),
              ),
            ),
            search.isNotEmpty
                ? Expanded(
                    child: Semantics(
                      label: l10n.accLabelResultadoBusqueda,
                      hint: l10n.accHintResultadoBusqueda,
                      child: FutureBuilder(
                        future: context
                            .read<SupabaseService>()
                            .getHistorialByNameProduct(search),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final historial = snapshot.data;
                          if (historial == null || historial.isEmpty) {
                            return Text(l10n.sinResultados);
                          }
                          return ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: historial.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                ),
                                child: HistoryRegisterAdministrationWidget(
                                  register: Register(
                                    user: historial[index]['users']['username'],
                                    name: historial[index]['users']['name'],
                                    product:
                                        historial[index]['product']['product'],
                                    typeRegiser:
                                        historial[index]['type_register']['type_register'],
                                    type:
                                        historial[index]['product']['type']['type'],
                                    location:
                                        historial[index]['product']['location']['location'],
                                    date: context
                                        .read<HistoryRegisterViewmodel>()
                                        .parseDateToString(
                                          historial[index]['date'],
                                        ),
                                    quantity: historial[index]['quantity'],
                                    duration: historial[index]['duration'],
                                    description:
                                        historial[index]['description'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: SingleChildScrollView(
                        child: Text(l10n.introducirNombre),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
