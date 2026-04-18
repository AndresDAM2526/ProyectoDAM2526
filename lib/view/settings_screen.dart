import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String? _idioma;
  double sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? Column(
              children: [
                Container(
                  color: Colors.amber,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text("Modo oscuro"),
                    children: [
                      ListTile(
                        leading: Text("Modo oscuro"),
                        title: Switch(
                          value: _darkMode,
                          onChanged: (value) {
                            setState(() {
                              _darkMode = !_darkMode;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.amber,
                  child: ExpansionTile(
                    expansionAnimationStyle: AnimationStyle(
                      curve: Curves.bounceIn,
                    ),
                    title: Text("Idioma"),
                    children: [
                      ListTile(
                        leading: Text("Idioma"),
                        title: DropdownButtonFormField(
                          initialValue: "Español",
                          items: [
                            DropdownMenuItem(
                              value: "Español",
                              child: Text("Español"),
                            ),
                            DropdownMenuItem(
                              value: "Ingles",
                              child: Text("Ingles"),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _idioma = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.amber,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text("Tamaño de la fuente"),
                    children: [
                      Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.amber,
                    margin: EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text("Modo oscuro"),
                      children: [
                        ListTile(
                          leading: Text("Modo oscuro"),
                          title: Switch(
                            value: _darkMode,
                            onChanged: (value) {
                              setState(() {
                                _darkMode = !_darkMode;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.amber,
                    child: ExpansionTile(
                      expansionAnimationStyle: AnimationStyle(
                        curve: Curves.bounceIn,
                      ),
                      title: Text("Idioma"),
                      children: [
                        ListTile(
                          leading: Text("Idioma"),
                          title: DropdownButtonFormField(
                            initialValue: "Español",
                            items: [
                              DropdownMenuItem(
                                value: "Español",
                                child: Text("Español"),
                              ),
                              DropdownMenuItem(
                                value: "Ingles",
                                child: Text("Ingles"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _idioma = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    margin: EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text("Tamaño de la fuente"),
                      children: [
                        Slider(
                          value: sliderValue,
                          onChanged: (value) {
                            setState(() {
                              sliderValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
