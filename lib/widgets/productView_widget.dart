import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';

class ProductViewWidget extends StatelessWidget {
  int idProduct;
  String name;
  String location;
  String type;
  int quantity;
  ProductViewWidget({
    super.key,
    required this.idProduct,
    required this.name,
    required this.location,
    required this.type,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Nombre: $name"),
              Text("Nombre: $location"),
              Text("Nombre: $quantity"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  context.read<DatabaseService>().deleteProduct(idProduct);
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.person_4)),
            ],
          ),
        ],
      ),
    );
  }
}
