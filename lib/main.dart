import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/Product.dart';
import 'package:proyecto_dam_2526/view/addProduct_screen.dart';
import 'package:proyecto_dam_2526/view/modifyInventory_screen.dart';
import 'package:proyecto_dam_2526/view/getProduct_screen.dart';
import 'package:proyecto_dam_2526/view/inventory_screen.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';
import 'package:proyecto_dam_2526/view/settings_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/widgets/productView_widget.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => AddProductoFormViewModel()),
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
    return Consumer<DatabaseService>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
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
            body: /*ProductInformation(
          product: Product(
            name: "Raton",
            type: "Hardware",
            location: "Sala-01",
          ),
        ),*/
                //screens[selectedScreen],
                //AddProductScreen()
                //LoginScreen(),
                //ProductViewWidget()
                //ModifyProductScreen()
                ModifyInventory(),
          ),
        );
      },
    );
  }
}
