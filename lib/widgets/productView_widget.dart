import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';

class ProductViewWidget extends StatelessWidget {
  int idProduct;
  String name;
  String location;
  String type;
  int quantity;
  Widget rightSideWidget;
  Widget leftSideWidget;
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
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nombre: $name"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ubicación: $location"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Cantidad: $quantity"),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [leftSideWidget, rightSideWidget],
            ),
          ),
        ],
      ),
    );
  }
}
