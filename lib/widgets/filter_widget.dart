import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text("Filtrar por:")),
      body: Row(
        children: [
          NavigationRail(
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
          selectedIndex == 0
              ? Expanded(
                  child: FutureBuilder(
                    future: context.read<SupabaseService>().showLocations(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Error al cargar los datos");
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
                )
              : Expanded(
                  child: FutureBuilder(
                    future: context.read<SupabaseService>().showTypes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Error al cargar los datos");
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop<List<String?>?>(context, [
            selectedLocationRadio,
            selectedTypeRadio,
          ]);
        },
        child: Text("Filtrar"),
      ),
    );
  }
}
