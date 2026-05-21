import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';

class HistoryRegisterWidget extends StatelessWidget {
  String name;
  String location;
  String typeProduct;
  String typeRegister;
  String date;
  int quantity;
  String? duration;
  String? description;
  HistoryRegisterWidget({
    super.key,
    required this.name,
    required this.location,
    required this.typeProduct,
    required this.typeRegister,
    required this.date,
    required this.quantity,
    required this.duration,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.only(top: 10, right: 15, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
            children: [
              Text(
                "${l10n.tipoRegistro}: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(typeRegister),
            ],
          ),
          Row(
            children: [
              Text(
                "${l10n.fecha}: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                context.read<HistoryRegisterViewmodel>().parseDateToString(
                  date,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${l10n.cantidad}: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("$quantity"),
            ],
          ),
          (typeRegister == "Coger")
              ? Row(
                  children: [
                    Text(
                      "${l10n.duracion}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("$duration"),
                  ],
                )
              : SizedBox(),
          (typeRegister == "Coger")
              ? Row(
                  children: [
                    Text(
                      "${l10n.descripcion}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        "$description",
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 5,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
