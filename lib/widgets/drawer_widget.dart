import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/administration_screen.dart';
import 'package:proyecto_dam_2526/view/profile_screen.dart';
import 'package:proyecto_dam_2526/view/userHistory_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class DrawerWidget extends StatelessWidget {
  AppLocalizations l10n;
  DrawerWidget({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Expanded(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: Text(
                context.read<AuthService>().userDatabase!.name,
                style: TextStyle(
                  fontSize: context.watch<ThemeViewmodel>().originalFontSize,
                ),
                maxLines: 2,
              ),
              accountEmail: Text(
                context.read<AuthService>().userDatabase!.email,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: context.watch<ThemeViewmodel>().originalFontSize,
                ),
                maxLines: 2,
              ),
            ),
          ),
          ListTile(
            title: Text(l10n.miPerfil),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    user: context.read<AuthService>().userDatabase,
                  ),
                ),
              );
            },
          ),

          ListTile(
            title: Text(l10n.historial),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserHistoryScreen()),
              );
            },
          ),

          (context.read<AuthService>().userDatabase != null &&
                  context.read<AuthService>().userDatabase!.role ==
                      "Administrador")
              ? ListTile(
                  title: Text(l10n.administracion),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdministrationScreen(),
                      ),
                    );
                  },
                )
              : Spacer(),
          Spacer(),
          ListTile(
            title: IconButton(
              onPressed: () {
                context.read<AuthService>().logOut();
              },
              icon: Icon(Icons.logout),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
