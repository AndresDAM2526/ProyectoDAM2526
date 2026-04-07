import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => AddProductFormViewModel()),
        ChangeNotifierProvider(
          create: (context) => ModifyProductformViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => LoginFormViewmodel()),
        ChangeNotifierProvider(
          create: (context) => AdministrationscreenViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => AdduserFormViewmodel()),
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
  List<Widget> screens = [
    GetProductScreen(),
    InventoryScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    int selectedScreen = 0;
    return Consumer<DatabaseService>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) {
              return Scaffold(
                bottomNavigationBar:
                    context.read<DatabaseService>().userDatabase == null
                    ? null
                    : BottomNavigationBar(
                        currentIndex: selectedScreen,
                        onTap: (value) {
                          setState(() {
                            selectedScreen = value;
                          });
                        },
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.note),
                            label: "Obtener",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.inventory),
                            label: "Inventario",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.settings),
                            label: "Ajustes",
                          ),
                        ],
                      ),
                appBar: AppBar(
                  title: Center(child: Text("Gestión del inventario")),
                  backgroundColor: Colors.grey,
                ),
                drawer: context.read<DatabaseService>().userDatabase == null
                    ? null
                    : Drawer(
                        child: ListView(
                          children: [
                            ListTile(
                              title: Text("Mi perfil"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text("Historial"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserHistoryScreen(),
                                  ),
                                );
                              },
                            ),

                            ?(context.read<DatabaseService>().userDatabase !=
                                        null &&
                                    context
                                            .read<DatabaseService>()
                                            .userDatabase!
                                            .role ==
                                        "Admin")
                                ? ListTile(
                                    title: Text("Adminstración"),
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
                          ],
                        ),
                      ),
                body: context.read<DatabaseService>().userDatabase == null
                    ? LoginScreen()
                    : screens[selectedScreen],
              );
            },
          ),
        );
      },
    );
  }
}
