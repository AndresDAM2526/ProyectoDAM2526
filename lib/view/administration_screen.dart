import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/view/addProduct_screen.dart';
import 'package:proyecto_dam_2526/view/addUser_screen.dart';
import 'package:proyecto_dam_2526/view/modifyInventory_screen.dart';
import 'package:proyecto_dam_2526/view/modifyUser_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class AdministrationScreen extends StatelessWidget {
  const AdministrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(l10n.administracion))),
      body: Column(
        children: [
          Text(l10n.usuarios),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddUserScreen()),
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
                  child: Text(l10n.anadirUsuario),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyUserScreen()),
                  );
                },
                child: Text(l10n.modificarUsuario),
              ),
            ],
          ),

          Text(l10n.inventario),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
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
                  child: Text(l10n.anadirProducto),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  context
                      .read<AdministrationscreenViewmodel>()
                      .showAddLocationDialog(context,l10n);
                },
                child: Text(l10n.anadirUbicacion),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<AdministrationscreenViewmodel>()
                        .showAddTypeProductDialog(context,l10n);
                  },
                  child: Text(l10n.anadirTipo),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyInventory()),
                  );
                },
                child: Text(l10n.modificarInventario),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
