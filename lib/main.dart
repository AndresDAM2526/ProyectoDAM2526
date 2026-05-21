import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/utils/providersCustom.dart';
import 'package:proyecto_dam_2526/utils/themeDataLight.dart';
import 'package:proyecto_dam_2526/view/getProduct_screen.dart';
import 'package:proyecto_dam_2526/view/inventory_screen.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/view/settings_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/drawer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eaqorymjfnwydgfxkikc.supabase.co',
    anonKey: 'sb_publishable_V7nv-Abe7PosATw_yowgRw_2jn0KD_0',
  );
  runApp(MultiProvider(providers: ProvidersCustom.providers, child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> screens = [
    GetProductScreen(),
    InventoryScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeDataCustom().themeDataLight(context),
      darkTheme: ThemeDataCustom().themeDataDark(context),
      themeMode: context.watch<ThemeViewmodel>().theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es')],
      locale: context.watch<ThemeViewmodel>().currentLang,
      home: PopScope(
        canPop: true,
        child: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            if (context.watch<AuthService>().userDatabase == null) {
              return Scaffold(body: LoginScreen());
            }
            return Scaffold(
              bottomNavigationBar:
                  context.read<AuthService>().userDatabase == null
                  ? null
                  : BottomNavigationBar(
                      currentIndex: context.watch<AuthService>().selectedScreen,
                      onTap: (value) {
                        setState(() {
                          context.read<AuthService>().selectedScreen = value;
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.note),
                          label: l10n.obtener,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.inventory),
                          label: l10n.inventario,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: l10n.ajustes,
                        ),
                      ],
                    ),
              appBar: AppBar(title: Center(child: Text(l10n.nombreApp))),
              drawer: context.read<AuthService>().userDatabase == null
                  ? null
                  : DrawerWidget(l10n: l10n),
              body: screens[context.watch<AuthService>().selectedScreen],
            );
          },
        ),
      ),
    );
  }
}
