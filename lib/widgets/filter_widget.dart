import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

import 'package:proyecto_dam_2526/service/supabase_service.dart';

class FilterWidget extends StatefulWidget {
  FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? selectedLocationRadio;
  String? selectedTypeRadio;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.filtrarPor)),
      body: Row(
        children: [
          Semantics(
            label: l10n.accLabelMenuLateral,
            hint: l10n.accHintMenuLateral,
            child: NavigationRail(
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.location_on_sharp),
                  label: Text("location"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.computer),
                  label: Text("data"),
                ),
              ],
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              selectedIndex: selectedIndex,
            ),
          ),
          selectedIndex == 0
              ? Expanded(
                  child: Semantics(
                    label: l10n.accLabelListadoUbicaciones,
                    hint: l10n.accHintListadoUbicaciones,
                    child: FutureBuilder(
                      future: context.read<SupabaseService>().showLocations(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(l10n.errorCargaDatos);
                        }
                        final elementList = snapshot.data;
                        return RadioGroup<String>(
                          groupValue: selectedLocationRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedLocationRadio = value;
                            });
                          },
                          child: ListView.builder(
                            itemCount: elementList!.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: ListTile(
                                  leading: Radio(value: elementList[index]),
                                  title: Text(elementList[index]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                child: Semantics(
                  label: l10n.accLabelListadoTiposProducto,
                  hint: l10n.accHintListadoTiposProducto,
                  child: FutureBuilder(
                    future: context.read<SupabaseService>().showTypes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(l10n.errorCargaDatos);
                      }
                      final elementList = snapshot.data;
                      return RadioGroup<String>(
                        groupValue: selectedTypeRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedTypeRadio = value;
                          });
                        },
                        child: ListView.builder(
                          itemCount: elementList!.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: ListTile(
                                leading: Radio(value: elementList[index]),
                                title: Text(elementList[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
        ],
      ),
      floatingActionButton: Semantics(
        label: l10n.accLabelBtnFiltrar,
        hint: l10n.accHintBtnFiltrar,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop<List<String?>?>(context, [
              selectedLocationRadio,
              selectedTypeRadio,
            ]);
          },
          child: Icon(Icons.filter_list_rounded),
        ),
      ),
    );
  }
}
