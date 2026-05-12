import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(2),
            child: TextField(
              decoration: InputDecoration(label: Text(l10n.introducirNombre)),
              onSubmitted: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: context.watch<SupabaseService>().getProductsFromName(
                name!,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(

                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/10,
                    color: Colors.amber,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(l10n.errorCargaDatos);
                }
                final foundProducts = snapshot.data!;
                if (foundProducts.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        l10n.sinResultados,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: foundProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ProductViewWidget(
                          idProduct: foundProducts[index]['id_product'],
                          name: foundProducts[index]['product'],
                          location:
                              foundProducts[index]['location']['location'],
                          type: foundProducts[index]['type']['type'],
                          quantity: foundProducts[index]['quantity'],
                          leftSideWidget: IconButton(
                            onPressed: () {
                              context
                                  .read<GetProductViewmodel>()
                                  .showGetProductWidgetDialog(
                                    context,
                                    l10n,
                                    RequestProduct(
                                      idProduct:
                                          foundProducts[index]['id_product'],
                                      name: foundProducts[index]['product'],
                                      type:
                                          foundProducts[index]['type']['type'],
                                      location:
                                          foundProducts[index]['location']['location'],
                                    ),
                                    foundProducts[index]['quantity'],
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
                                    l10n,
                                    RequestProduct(
                                      idProduct:
                                          foundProducts[index]['id_product'],
                                      name: foundProducts[index]['product'],
                                      type:
                                          foundProducts[index]['type']['type'],
                                      location:
                                          foundProducts[index]['location']['location'],
                                    ),
                                    foundProducts[index]['quantity'],
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
