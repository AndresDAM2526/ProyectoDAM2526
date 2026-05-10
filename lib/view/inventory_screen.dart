import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/view/product_information.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/inventoryScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/productsTable_widget.dart';
import 'package:sqflite/sqflite.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<InventoryScreenViewmodel>().showFilterDialog(
                        context,
                      );
                    },
                    child: Text(l10n.filtro),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SupabaseService>().clearFilter();
                    },
                    child: Text(l10n.quitarFiltro),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(15),
              child: context.watch<SupabaseService>().filteredProducts == null
                  ? ProductsTableWidget(
                      productList: context.read<SupabaseService>().products,
                    )
                  : context.read<SupabaseService>().filteredProducts!.isEmpty
                  ? Text(l10n.sinResultados)
                  : ProductsTableWidget(
                      productList: context
                          .read<SupabaseService>()
                          .filteredProducts!,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
