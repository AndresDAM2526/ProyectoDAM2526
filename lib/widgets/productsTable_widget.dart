import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';

class ProductsTableWidget extends StatefulWidget {
  List<Map<String, dynamic>> productList;
  ProductsTableWidget({super.key, required this.productList});

  @override
  State<ProductsTableWidget> createState() => _ProductsTableWidgetState();
}

class _ProductsTableWidgetState extends State<ProductsTableWidget> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
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
      rows: widget.productList
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
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 2,
                            child: ProductInformation(
                              product: Product(
                                name: product['product'],
                                type: product['type'],
                                location: product['location'],
                                quantity: int.parse(product['quantity']),
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
                      child: Text(product['product']),
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
                      child: Text(product['type']),
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
                      child: Text(product['location']),
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
