import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/searchProductFrom_viewmodel.dart';

class ModifyProductScreen extends StatefulWidget {
  const ModifyProductScreen({super.key});

  @override
  State<ModifyProductScreen> createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {
  String? name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modificar producto")),
      body: Column(
        children: [
          SearchBar(
            hintText: "Introduzca el nombre del producto",
            onSubmitted: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: context.read<DatabaseService>().getProductsFromName(
                name!,
              ),
              builder: (context, snapshot) {
                final foundProducts = snapshot.data??[];
                return ListView.builder(
                  itemCount: foundProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(foundProducts[index]['product']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
