import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> databaseProducts = context
        .watch<DatabaseService>()
        .products;
    List<Product> products = databaseProducts
        .map(
          (product) => Product(
            name: product['product'],
            type: product['type'],
            location: product['location'],
            quantity: int.parse(product['quantity']),
          ),
        )
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text("Filtro"), Text("Filtro")],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15),
              child: DataTable(
                horizontalMargin: 5,
                dataRowMinHeight: 0,
                dataRowMaxHeight: double.infinity,
                border: TableBorder.all(width: 1),
                columns: [
                  DataColumn(
                    label: Expanded(child: Center(child: Text("Nombre"))),
                  ),
                  DataColumn(
                    label: Expanded(child: Center(child: Text("Tipo"))),
                  ),
                  DataColumn(
                    label: Expanded(child: Center(child: Text("Ubicación"))),
                  ),
                ],
                rows: products
                    .map(
                      (product) => DataRow(
                        cells: [
                          DataCell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                          2,
                                      child: ProductInformation(
                                        product: Product(
                                          name: product.name,
                                          type: product.type,
                                          location: product.location,
                                          quantity: product.quantity,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: double.infinity,
                                maxWidth: MediaQuery.of(context).size.width / 4,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(product.name),
                              ),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: double.infinity,
                                maxWidth: MediaQuery.of(context).size.width / 5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(product.type),
                              ),
                            ),
                          ),
                          DataCell(
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: double.infinity,
                                maxWidth: MediaQuery.of(context).size.width / 5,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(product.location),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
