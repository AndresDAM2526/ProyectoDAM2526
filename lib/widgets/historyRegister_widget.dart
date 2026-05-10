import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';

class HistoryRegisterWidget extends StatelessWidget {
  String name;
  String location;
  String typeProduct;
  String typeRegister;
  String date;
  int quantity;
  HistoryRegisterWidget({
    super.key,
    required this.name,
    required this.location,
    required this.typeProduct,
    required this.typeRegister,
    required this.date,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, right: 15, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${l10n.nombre}: $name"),
              Text("${l10n.tipoProducto}: $typeProduct"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 10, left: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${l10n.tipoRegistro}: $typeRegister"),
              Text("${l10n.cantidad}: $quantity"),
              Text("${l10n.fecha}: $date"),
            ],
          ),
        ),
      ],
    );
  }
}
