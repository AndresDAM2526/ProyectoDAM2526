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

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Center(child: Text(l10n.administracion)),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
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
                                MediaQuery.of(context).size.width / 2,
                                MediaQuery.of(context).size.height / 3,
                                l10n.nuevoUsuarioMensaje,
                              );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l10n.anadirUsuario,
                            style: TextStyle(color: Colors.black),
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
                          color: AppColors.secondary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(l10n.modificarUsuario),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: Text(l10n.inventario),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductScreen(),
                            ),
                          );
                          if (result == true) {
                            await context
                                .read<MessagesViewmodel>()
                                .showInformationDialog(
                                  context,
                                  MediaQuery.of(context).size.width / 2,
                                  MediaQuery.of(context).size.height / 3,
                                  l10n.nuevoProductoMensaje,
                                );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.anadirProducto,
                              style: TextStyle(color: Colors.black),
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
                            color: AppColors.secondary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l10n.modificarInventario,
                              style: TextStyle(color: Colors.black),
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
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.historial,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            title: Text(l10n.ubicacion),
            children: [
              Row(
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
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.anadirUbicacion,
                          style: TextStyle(color: Colors.black),
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
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.borrarUbicacion,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
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
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.anadirTipo,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TypesScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.borrarTipo,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
