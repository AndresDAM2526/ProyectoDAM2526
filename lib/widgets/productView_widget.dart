import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/view/modifyProduct_screen.dart';

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
              IconButton(
                onPressed: () {
                  showModifyDialog(
                    context,
                    DatabaseProduct(
                      idProduct: idProduct,
                      name: name,
                      type: type,
                      location: location,
                      quantity: quantity,
                    ),
                  );
                },
                icon: Icon(Icons.person_4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showModifyDialog(BuildContext context, DatabaseProduct product) async {
    final bool? modified = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: ModifyProductScreen(
                product: DatabaseProduct(
                  idProduct: idProduct,
                  name: name,
                  type: type,
                  location: location,
                  quantity: quantity,
                ),
              ),
            ),
          ),
        );
      },
    );

    if (modified == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Modificado")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No se ha modificado")));
    }
  }
}
