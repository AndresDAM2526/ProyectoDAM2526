import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';

class ProductsTableWidget extends StatefulWidget {
  List<Map<String, dynamic>?> productList;
  ProductsTableWidget({super.key, required this.productList});

  @override
  State<ProductsTableWidget> createState() => _ProductsTableWidgetState();
}

class _ProductsTableWidgetState extends State<ProductsTableWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: DataTable(
          horizontalMargin: 5,
          dataRowMinHeight: 0,
          dataRowMaxHeight: double.infinity,
          border: TableBorder.all(
            width: 1,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          columns: [
            DataColumn(
              label: Expanded(child: Center(child: Text(l10n.nombre))),
            ),
            DataColumn(
              label: Expanded(child: Center(child: Text(l10n.tipo))),
            ),
            DataColumn(
              label: Expanded(child: Center(child: Text(l10n.ubicacion))),
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
                                width:
                                    (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? MediaQuery.of(context).size.width / 3
                                    : MediaQuery.of(context).size.width,
                                height:
                                    (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? MediaQuery.of(context).size.height / 2
                                    : MediaQuery.of(context).size.height,
                                child: ProductInformation(
                                  product: Product(
                                    name: product['product'],
                                    type: product['type']['type'],
                                    location: product['location']['location'],
                                    quantity: product['quantity'],
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
                          padding: EdgeInsets.only(
                            top: 5,
                            left: 2,
                            right: 2,
                            bottom: 5,
                          ),
                          child: Text(
                            product!['product'],
                            style: TextStyle(
                              color: product['quantity'] == 0
                                  ? AppColors.notStockFontColor
                                  : Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                          maxWidth: MediaQuery.of(context).size.width / 5,
                        ),
                        child: Text(
                          product['type']['type'],
                          style: TextStyle(
                            color: product['quantity'] == 0
                                ? AppColors.notStockFontColor
                                : Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                          maxWidth: MediaQuery.of(context).size.width / 5,
                        ),
                        child: Text(
                          product['location']['location'],
                          style: TextStyle(
                            color: product['quantity'] == 0
                                ? AppColors.notStockFontColor
                                : Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
