import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/productView_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModifyInventory extends StatefulWidget {
  const ModifyInventory({super.key});

  @override
  State<ModifyInventory> createState() => _ModifyInventoryState();
}

class _ModifyInventoryState extends State<ModifyInventory> {
  String? name = "";
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: Center(child: Text(l10n.modificarInventario)),backgroundColor: AppColors.primary,),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Center(child: Text(l10n.introducirNombre)),
                ),
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          ),
          FutureBuilder(
            future: context.watch<SupabaseService>().getProductsFromName(
              name!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (!snapshot.hasData) {
                return Center(child: Text(l10n.sinResultados));
              }
              final products = snapshot.data ?? [];
              return Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: ProductViewWidget(
                          idProduct: products[index]['id_product'],
                          name: products[index]['product'],
                          location: products[index]['location']['location'],
                          type: products[index]['type']['type'],
                          quantity: products[index]['quantity'],
                          leftSideWidget: IconButton(
                            onPressed: () {
                              context.read<SupabaseService>().deleteProduct(
                                products[index]['id_product'],
                              );
                              context
                                  .read<MessagesViewmodel>()
                                  .showInformationDialog(
                                    context,
                                    MediaQuery.of(context).size.width / 2,
                                    MediaQuery.of(context).size.height / 3,
                                    l10n.productoBorrado,
                                  );
                            },
                            icon: Icon(Icons.delete),
                          ),
                          rightSideWidget: IconButton(
                            onPressed: () {
                              context
                                  .read<AdministrationscreenViewmodel>()
                                  .showModifyProductDialog(
                                    context,
                                    l10n,
                                    DatabaseProduct(
                                      idProduct: products[index]['id_product'],
                                      name: products[index]['product'],
                                      type: products[index]['type']['type'],
                                      location:
                                          products[index]['location']['location'],
                                      quantity: products[index]['quantity'],
                                    ),
                                  );
                            },
                            icon: Icon(Icons.app_registration_sharp),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
