import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/Product.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Product> productosPrueba = [
    Product(name: "Ratón", type: "Hardware", location: "Sala-01"),
    Product(name: "Ordenador", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(
      name: "Cable USBasdasdasdasdaasdasdasdasdasdasddgggfyhgs",
      type: "Hardware",
      location: "Sala-01",
    ),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01dfsgdfgfd"),
    Product(name: "Cable USB", type: "Hardware", location: "Sala-01"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Text("Filtro"), Text("Filtro")],
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
                  DataColumn(label: Expanded(child: Text("Nombre"))),
                  DataColumn(label: Expanded(child: Text("Tipo"))),
                  DataColumn(label: Expanded(child: Text("Ubicación"))),
                ],
                rows: productosPrueba
                    .map(
                      (producto) => DataRow(
                        cells: [
                          DataCell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/3,
                                      height: MediaQuery.of(context).size.height/3,
                                      child: ProductInformation(
                                        product: Product(
                                          name: producto.name,
                                          type: producto.type,
                                          location: producto.location,
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
                                maxWidth: MediaQuery.of(context).size.width / 5,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(producto.name),
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
                                child: Text(producto.type),
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
                                child: Text(producto.location),
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
