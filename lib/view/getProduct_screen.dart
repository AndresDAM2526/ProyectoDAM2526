import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/productView_widget.dart';
import 'package:proyecto_dam_2526/widgets/transactions_widget.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  String? name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(label: Text("Introduzca el nombre")),
            onSubmitted: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: context.watch<DatabaseService>().getProductsFromName(
                name!,
              ),
              builder: (context, snapshot) {
                final foundProducts = snapshot.data ?? [];
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: foundProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ProductViewWidget(
                          idProduct: foundProducts[index]['idProduct'],
                          name: foundProducts[index]['product'],
                          location: foundProducts[index]['location'],
                          type: foundProducts[index]['type'],
                          quantity: int.parse(foundProducts[index]['quantity']),
                          leftSideWidget: IconButton(
                            onPressed: () {
                              context
                                  .read<GetProductViewmodel>()
                                  .showGetProductWidgetDialog(
                                    context,
                                    RequestProduct(
                                      idProduct:
                                          foundProducts[index]['idProduct'],
                                      name: foundProducts[index]['product'],
                                      type: foundProducts[index]['type'],
                                      location:
                                          foundProducts[index]['location'],
                                    ),
                                    int.parse(foundProducts[index]['quantity']),
                                    "Coger",
                                  );
                            },
                            icon: Icon(Icons.get_app),
                          ),
                          rightSideWidget: IconButton(
                            onPressed: () {
                              context
                                  .read<GetProductViewmodel>()
                                  .showGetProductWidgetDialog(
                                    context,
                                    RequestProduct(
                                      idProduct:
                                          foundProducts[index]['idProduct'],
                                      name: foundProducts[index]['product'],
                                      type: foundProducts[index]['type'],
                                      location:
                                          foundProducts[index]['location'],
                                    ),
                                    int.parse(foundProducts[index]['quantity']),
                                    "Devolver",
                                  );
                            },
                            icon: Icon(Icons.backup),
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
}
