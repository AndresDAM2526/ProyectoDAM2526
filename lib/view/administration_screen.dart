import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/addProduct_screen.dart';
import 'package:proyecto_dam_2526/view/addUser_screen.dart';
import 'package:proyecto_dam_2526/view/historial_screen.dart';
import 'package:proyecto_dam_2526/view/locations_screen.dart';
import 'package:proyecto_dam_2526/view/modifyInventory_screen.dart';
import 'package:proyecto_dam_2526/view/modifyUser_screen.dart';
import 'package:proyecto_dam_2526/view/types_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n.administracion))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: ExpansionTile(
                title: Text(l10n.usuarios),
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddUserScreen(),
                            ),
                          );
                          if (result == true) {
                            await context
                                .read<MessagesViewmodel>()
                                .showInformationDialog(
                                  context,
                                  MediaQuery.of(context).size.width,
                                  (context.read<ThemeViewmodel>().fontSize < 24)
                                      ? MediaQuery.of(context).size.height / 3
                                      : MediaQuery.of(context).size.height *
                                            0.4,
                                  l10n.nuevoUsuarioMensaje,
                                );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.anadirUsuario,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ModifyUserScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.modificarUsuario,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(l10n.inventario),
                children: [
                  Column(
                    children: [
                      (context.read<ThemeViewmodel>().fontSize < 24)
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    bool? result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddProductScreen(),
                                      ),
                                    );
                                    if (result == true) {
                                      await context
                                          .read<MessagesViewmodel>()
                                          .showInformationDialog(
                                            context,
                                            MediaQuery.of(context).size.width,
                                            (context
                                                        .read<ThemeViewmodel>()
                                                        .fontSize <
                                                    24)
                                                ? MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      3
                                                : MediaQuery.of(
                                                        context,
                                                      ).size.height *
                                                      0.4,
                                            l10n.nuevoProductoMensaje,
                                          );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        l10n.anadirProducto,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ModifyInventory(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        l10n.modificarInventario,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    bool? result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddProductScreen(),
                                      ),
                                    );
                                    if (result == true) {
                                      await context
                                          .read<MessagesViewmodel>()
                                          .showInformationDialog(
                                            context,
                                            MediaQuery.of(context).size.width,
                                            (context
                                                        .read<ThemeViewmodel>()
                                                        .fontSize <
                                                    24)
                                                ? MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      3
                                                : MediaQuery.of(
                                                        context,
                                                      ).size.height *
                                                      0.4,
                                            l10n.nuevoProductoMensaje,
                                          );
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        l10n.anadirProducto,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ModifyInventory(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        l10n.modificarInventario,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistorialScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.historial,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(l10n.ubicacion),
                children: [
                  (context.read<ThemeViewmodel>().fontSize < 24)
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<AdministrationscreenViewmodel>()
                                    .showAddLocationDialog(context, l10n);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    l10n.anadirUbicacion,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    l10n.borrarUbicacion,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<AdministrationscreenViewmodel>()
                                    .showAddLocationDialog(context, l10n);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    l10n.anadirUbicacion,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LocationsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    l10n.borrarUbicacion,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(l10n.tipo),
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AdministrationscreenViewmodel>()
                              .showAddTypeProductDialog(context, l10n);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.anadirTipo,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TypesScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.borrarTipo,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
