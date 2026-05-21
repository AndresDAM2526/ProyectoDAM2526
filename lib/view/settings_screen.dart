import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Semantics(
                    label: l10n.accLabelApartadoModoOscuro,
                    hint: l10n.accHintApartadoModoOscuro,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(l10n.modoOscuro),
                        children: [
                          ListTile(
                            title: Semantics(
                              label: l10n.accLabelSelectorEstilo,
                              hint:
                                  l10n.accHintSelectorEstilo,
                              child: Switch(
                                value: context.watch<ThemeViewmodel>().darkMode,
                                onChanged: (value) {
                                  setState(() {
                                    context
                                        .read<ThemeViewmodel>()
                                        .changeTheme();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    label: l10n.accLabelApartadoIdioma,
                    hint: l10n.accHintApartadoIdioma,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        expansionAnimationStyle: AnimationStyle(
                          curve: Curves.bounceIn,
                        ),
                        title: Text(l10n.idioma),
                        children: [
                          ListTile(
                            title: Semantics(
                              label: l10n.accLabelDesplegableIdioma,
                              hint: l10n.accHintDesplegableIdioma,
                              child: DropdownButtonFormField(
                                initialValue: context
                                    .read<ThemeViewmodel>()
                                    .lang,
                                items: [
                                  DropdownMenuItem(
                                    value: "es",
                                    child: Text("Español"),
                                  ),
                                  DropdownMenuItem(
                                    value: "en",
                                    child: Text("English"),
                                  ),
                                ],
                                onChanged: (value) {
                                  context.read<ThemeViewmodel>().changeLang(
                                    value!,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    label: l10n.accLabelApartadoTamanoFuente,
                    hint: l10n.accHintApartadoTamanoFuente,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(l10n.tamanioFuente),
                        children: [
                          Semantics(
                            label: l10n.accLabelBarraTamanioFuente,
                            hint: l10n.accHintBarraTamanioFuente,
                            child: Slider(
                              divisions: 4,
                              min: 1,
                              max: 1.5,
                              value: context.watch<ThemeViewmodel>().multiplier,
                              onChanged: (value) {
                                print(context.read<ThemeViewmodel>().fontSize);
                                context.read<ThemeViewmodel>().changeFontSize(
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Semantics(
                    label: l10n.accLabelApartadoModoOscuro,
                    hint: l10n.accHintApartadoModoOscuro,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(l10n.modoOscuro),
                        children: [
                          ListTile(
                            title: Semantics(
                              label: l10n.accLabelSelectorEstilo,
                              hint:
                                  l10n.accHintSelectorEstilo,
                              child: Switch(
                                value: context.watch<ThemeViewmodel>().darkMode,
                                onChanged: (value) {
                                  setState(() {
                                    context
                                        .read<ThemeViewmodel>()
                                        .changeTheme();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    label: l10n.accLabelApartadoIdioma,
                    hint: l10n.accHintApartadoIdioma,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        expansionAnimationStyle: AnimationStyle(
                          curve: Curves.bounceIn,
                        ),
                        title: Text(l10n.idioma),
                        children: [
                          ListTile(
                            title: Semantics(
                              label: l10n.accLabelDesplegableIdioma,
                              hint: l10n.accHintDesplegableIdioma,
                              child: DropdownButtonFormField(
                                initialValue: context
                                    .read<ThemeViewmodel>()
                                    .lang,
                                items: [
                                  DropdownMenuItem(
                                    value: "es",
                                    child: Text("Español"),
                                  ),
                                  DropdownMenuItem(
                                    value: "en",
                                    child: Text("English"),
                                  ),
                                ],
                                onChanged: (value) {
                                  context.read<ThemeViewmodel>().changeLang(
                                    value!,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Semantics(
                    label: l10n.accLabelApartadoTamanoFuente,
                    hint: l10n.accHintApartadoTamanoFuente,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      child: ExpansionTile(
                        title: Text(l10n.tamanioFuente),
                        children: [
                          Semantics(
                            label: l10n.accLabelBarraTamanioFuente,
                            hint: l10n.accHintBarraTamanioFuente,
                            child: Slider(
                              divisions: 4,
                              min: 1,
                              max: 1.5,
                              value: context.watch<ThemeViewmodel>().multiplier,
                              onChanged: (value) {
                                print(context.read<ThemeViewmodel>().fontSize);
                                context.read<ThemeViewmodel>().changeFontSize(
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
