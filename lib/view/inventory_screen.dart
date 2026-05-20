import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/inventoryScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/productsTable_widget.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<String?> filters = [];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Semantics(
              label: l10n.accLabelBtnFiltrar,
              hint: l10n.accHintBtnFiltrar,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        filters = (await context
                            .read<InventoryScreenViewmodel>()
                            .showFilterDialog(context))!;
                      },
                      icon: Icon(Icons.filter_list),
                    ),
                    context.watch<SupabaseService>().filteredProducts != null
                        ? ElevatedButton(
                            onPressed: () {
                              context.read<SupabaseService>().clearFilter();
                              filters.clear();
                            },
                            child: Text(l10n.quitarFiltro),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            filters.isEmpty
                ? SizedBox.shrink()
                : filters[0] == ""
                ? Semantics(
                    label: l10n.accLabelTextoFiltros,
                    hint: l10n.accHintTextoFiltros,
                    child: Text(
                      filters[1].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : filters[1] == ""
                ? Semantics(
                    label: l10n.accLabelTextoFiltros,
                    hint: l10n.accHintTextoFiltros,
                    child: Text(
                      filters[0].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : Semantics(
                    label: l10n.accLabelTextoFiltros,
                    hint: l10n.accHintTextoFiltros,
                    child: Text(
                      filters.join("-"),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            Semantics(
              label: l10n.accLabelTbProductos,
              hint: l10n.accHintTbProductos,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: context.watch<SupabaseService>().filteredProducts == null
                    ? ProductsTableWidget(
                        productList: context.read<SupabaseService>().products,
                      )
                    : context.read<SupabaseService>().filteredProducts!.isEmpty
                    ? Center(child: Text(l10n.sinResultados))
                    : ProductsTableWidget(
                        productList: context
                            .read<SupabaseService>()
                            .filteredProducts!,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
