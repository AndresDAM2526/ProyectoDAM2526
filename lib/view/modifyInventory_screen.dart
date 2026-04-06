import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';
import 'package:proyecto_dam_2526/widgets/productView_widget.dart';

class ModifyInventory extends StatefulWidget {
  const ModifyInventory({super.key});

  @override
  State<ModifyInventory> createState() => _ModifyInventoryState();
}

class _ModifyInventoryState extends State<ModifyInventory> {
  String? name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Modificar inventario"))),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Center(child: Text("Introduzca el nombre")),
                ),
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          ),
          name!.isEmpty
              ? Center(child: Text(""))
              : Expanded(
                  child: FutureBuilder(
                    future: context.read<DatabaseService>().getProductsFromName(
                      name!,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("No se han encontrado resultados"),
                        );
                      }
                      final products = snapshot.data ?? [];
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: ProductViewWidget(
                                idProduct: products[index]['idProduct'],
                                name: products[index]['product'],
                                location: products[index]['location'],
                                type: products[index]['type'],
                                quantity: int.parse(
                                  products[index]['quantity'],
                                ),
                                leftSideWidget: IconButton(
                                  onPressed: () {
                                    context
                                        .read<DatabaseService>()
                                        .deleteProduct(
                                          products[index]['idProduct'],
                                        );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                rightSideWidget: IconButton(
                                  onPressed: () {
                                    showModifyDialog(
                                      context,
                                      DatabaseProduct(
                                        idProduct: products[index]['idProduct'],
                                        name: products[index]['product'],
                                        type: products[index]['type'],
                                        location: products[index]['location'],
                                        quantity: int.parse(
                                          products[index]['quantity'],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.app_registration_sharp),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void showModifyDialog(BuildContext context, DatabaseProduct product) async {
    final bool? modified = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: ModifyProductScreen(product: product),
            ),
          ),
        );
      },
    );

    if (modified == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Modificado")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No se ha modificado")));
    }
  }
}
