import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/widgets/productView_widget.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  String? name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(label: Text("Introduzca el nombre")),
            onSubmitted: (value) {
              setState(() {
                name = value;
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: context.read<DatabaseService>().getProductsFromName(
                name!,
              ),
              builder: (context, snapshot) {
                final foundProducts = snapshot.data ?? [];
                return Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: foundProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ProductViewWidget(
                          idProduct: foundProducts[index]['idProduct'],
                          name: foundProducts[index]['product'],
                          location: foundProducts[index]['location'],
                          type: foundProducts[index]['type'],
                          quantity: int.parse(foundProducts[index]['quantity']),
                          leftSideWidget: IconButton(
                            onPressed: () {
                              context.read<DatabaseService>().newRegister(
                                foundProducts[index]['idProduct'],
                                context.read<DatabaseService>().userDatabase!.idUser,
                                "Coger",
                                DateFormat.yMd().add_jm().format(
                                  DateTime.now(),
                                ),
                                1,
                              );
                            },
                            icon: Icon(Icons.get_app),
                          ),
                          rightSideWidget: IconButton(
                            onPressed: () {
                              context.read<DatabaseService>().newRegister(
                                foundProducts[index]['idProduct'],
                                context.read<DatabaseService>().userDatabase!.idUser,
                                "Devolver",
                                DateFormat.yMd().add_jm().format(
                                  DateTime.now(),
                                ),
                                1,
                              );
                            },
                            icon: Icon(Icons.restore_from_trash_rounded),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
