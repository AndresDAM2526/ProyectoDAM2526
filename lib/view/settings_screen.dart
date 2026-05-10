import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n.ajustes))),
      body: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? Column(
              children: [
                Container(
                  color: Colors.amber,
                  margin: EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text(l10n.modoOscuro),
                    children: [
                      ListTile(
                        leading: Text(l10n.modoOscuro),
                        title: Switch(
                          value: context.watch<ThemeViewmodel>().darkMode,
                          onChanged: (value) {
                            setState(() {
                              context.read<ThemeViewmodel>().changeTheme();
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
                    title: Text(l10n.idioma),
                    children: [
                      ListTile(
                        leading: Text(l10n.idioma),
                        title: DropdownButtonFormField(
                          initialValue: context.read<ThemeViewmodel>().lang,
                          items: [
                            DropdownMenuItem(
                              value: "es",
                              child: Text("Español"),
                            ),
                            DropdownMenuItem(
                              value: "en",
                              child: Text("Ingles"),
                            ),
                          ],
                          onChanged: (value) {
                            context.read<ThemeViewmodel>().changeLang(value!);
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
                    title: Text(l10n.tamanioFuente),
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
                      title: Text(l10n.modoOscuro),
                      children: [
                        ListTile(
                          leading: Text(l10n.modoOscuro),
                          title: Switch(
                            value: context.watch<ThemeViewmodel>().darkMode,
                            onChanged: (value) {
                              setState(() {
                                context.read<ThemeViewmodel>().changeTheme();
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
                      title: Text(l10n.idioma),
                      children: [
                        ListTile(
                          leading: Text(l10n.idioma),
                          title: DropdownButtonFormField(
                            initialValue: context.read<ThemeViewmodel>().lang,
                            items: [
                              DropdownMenuItem(
                                value: "es",
                                child: Text("Español"),
                              ),
                              DropdownMenuItem(
                                value: "en",
                                child: Text("Ingles"),
                              ),
                            ],
                            onChanged: (value) {
                              print("object");
                              context.read<ThemeViewmodel>().changeLang(value!);
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
                      title: Text(l10n.tamanioFuente),
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
