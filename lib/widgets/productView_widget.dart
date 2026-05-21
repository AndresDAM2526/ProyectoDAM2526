import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';

class ProductViewWidget extends StatelessWidget {
  int idProduct;
  String name;
  String location;
  String type;
  int quantity;
  Widget rightSideWidget;
  Widget? leftSideWidget;
  ProductViewWidget({
    super.key,
    required this.idProduct,
    required this.name,
    required this.location,
    required this.type,
    required this.quantity,
    required this.leftSideWidget,
    required this.rightSideWidget,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: quantity != 0
            ? Theme.of(context).colorScheme.surface
            : AppColors.notStock,
        border: Border.all(width: 1,color: Theme.of(context).colorScheme.inversePrimary),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${l10n.nombre}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${l10n.tipo}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        type,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${l10n.cantidad}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        "$quantity",
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${l10n.ubicacion}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [?leftSideWidget, rightSideWidget],
            ),
          ),
        ],
      ),
    );
  }
}
