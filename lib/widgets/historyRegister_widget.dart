import 'package:flutter/material.dart';

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
    return Container(
      color: Colors.amber,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, right: 15, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Nombre: $name"), Text("Tipo de producto: $typeProduct")],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tipo de registro: $typeRegister"),
                Text("Cantidad: $quantity"),
                Text("Fecha: $date"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
