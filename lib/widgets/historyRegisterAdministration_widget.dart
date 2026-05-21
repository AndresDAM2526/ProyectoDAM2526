import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/register.dart';

class HistoryRegisterAdministrationWidget extends StatelessWidget {
  Register register;
  HistoryRegisterAdministrationWidget({super.key, required this.register});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 15, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${l10n.fecha}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(register.date),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${l10n.producto}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        register.product,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      "${l10n.nombre}: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        register.name,
                        style: TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(l10n.informacion),
                    children: [
                      Row(
                        children: [
                          Text(
                            "${l10n.tipo}: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(register.type),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${l10n.ubicacion}: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(register.location),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${l10n.tipoRegistro}: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(register.typeRegiser),
                        ],
                      ),
                      (register.typeRegiser == "Coger")
                          ? Row(
                              children: [
                                Text(
                                  "${l10n.duracion}: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("${register.duration}"),
                              ],
                            )
                          : SizedBox(),

                      Row(
                        children: [
                          Text(
                            "${l10n.cantidad}: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${register.quantity}"),
                        ],
                      ),
                      (register.typeRegiser == "Coger")
                          ? Row(
                              children: [
                                Text(
                                  "${l10n.descripcion}: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    "${register.description}",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
