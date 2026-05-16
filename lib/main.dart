import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/administration_screen.dart';
import 'package:proyecto_dam_2526/view/getProduct_screen.dart';
import 'package:proyecto_dam_2526/view/inventory_screen.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/view/profile_screen.dart';
import 'package:proyecto_dam_2526/view/settings_screen.dart';
import 'package:proyecto_dam_2526/view/userHistory_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/inventoryScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/profileForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eaqorymjfnwydgfxkikc.supabase.co',
    anonKey: 'sb_publishable_V7nv-Abe7PosATw_yowgRw_2jn0KD_0',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => AddProductFormViewModel()),
        ChangeNotifierProvider(
          create: (context) => ModifyProductFormViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => LoginFormViewmodel()),
        ChangeNotifierProvider(
          create: (context) => AdministrationscreenViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => AdduserFormViewmodel()),
        ChangeNotifierProvider(create: (context) => ProfileFormViewmodel()),
        ChangeNotifierProvider(create: (context) => ModifyUserFormViewmodel()),
        ChangeNotifierProvider(create: (context) => InventoryScreenViewmodel()),
        ChangeNotifierProvider(create: (context) => GetProductViewmodel()),
        ChangeNotifierProvider(create: (context) => MessagesViewmodel()),
        ChangeNotifierProvider(create: (context) => SupabaseService()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => NewUserPasswordFormViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeViewmodel()),
        ChangeNotifierProvider(create: (context) => HistoryRegisterViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedScreen = 0;
  List<Widget> screens = [
    GetProductScreen(),
    InventoryScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          bodyLarge: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          labelLarge: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          bodyMedium: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          bodySmall: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          displayLarge: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          labelSmall: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
          labelMedium: TextStyle(
            fontSize: context.watch<ThemeViewmodel>().fontSize,
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
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
                      backgroundColor: AppColors.primary,
                      selectedItemColor: AppColors.secondary,
                      currentIndex: selectedScreen,
                      onTap: (value) {
                        setState(() {
                          selectedScreen = value;
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
              appBar: AppBar(
                title: Center(child: Text(l10n.nombreApp)),
                backgroundColor: AppColors.primary,
              ),
              drawer: context.read<AuthService>().userDatabase == null
                  ? null
                  : Drawer(
                      child: ListView(
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(color: AppColors.primary),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.nombreApp),
                                Text(
                                  "${l10n.usuario} : ${context.read<AuthService>().userDatabase!.username}",
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text(l10n.miPerfil),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    user: context
                                        .read<AuthService>()
                                        .userDatabase,
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
                                MaterialPageRoute(
                                  builder: (context) => UserHistoryScreen(),
                                ),
                              );
                            },
                          ),

                          ?(context.read<AuthService>().userDatabase != null &&
                                  context
                                          .read<AuthService>()
                                          .userDatabase!
                                          .role ==
                                      "Administrador")
                              ? ListTile(
                                  title: Text(l10n.administracion),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdministrationScreen(),
                                      ),
                                    );
                                  },
                                )
                              : null,

                          ListTile(
                            title: IconButton(
                              onPressed: () {
                                selectedScreen = 0;
                                context.read<AuthService>().logOut();
                              },
                              icon: Icon(Icons.logout),
                            ),
                          ),
                        ],
                      ),
                    ),
              body: screens[selectedScreen],
            );
          },
        ),
      ),
    );
  }
}
