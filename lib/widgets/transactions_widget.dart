import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';

class Transactions extends StatefulWidget {
  RequestProduct product;
  int? maxQuantity;
  String typeRequest;
  Transactions({
    super.key,
    required this.product,
    required this.maxQuantity,
    required this.typeRequest,
  });

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int userQuantity = 0;
  bool? readOnlyTextForm = false;
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: (widget.typeRequest.compareTo("Coger") == 0)
              ? Text("Obtener producto")
              : Text("Devolver producto"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Producto : ${widget.product.name}"),
                Text("Tipo : ${widget.product.type}"),
                Text("Ubicación : ${widget.product.location}"),
              ],
            ),
          ),

          Row(
            children: [
              Checkbox(
                value: readOnlyTextForm,
                onChanged: (value) {
                  setState(() {
                    readOnlyTextForm = value!;
                  });
                },
              ),
              Text("Introducir cantidad manualmente"),
            ],
          ),

          Form(
            key: checkForm,
            child: Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                readOnly: !readOnlyTextForm!,
                controller: context
                    .read<GetProductViewmodel>()
                    .quantityController,
                validator: (value) =>
                    context.read<GetProductViewmodel>().checkQuantity(value),
                decoration: InputDecoration(
                  label: (widget.typeRequest.compareTo("Coger") == 0)
                      ? Text("Unidades disponibles: ${widget.maxQuantity}")
                      : Text("Unidades a devolver"),
                  prefixIcon: IconButton(
                    onPressed: () {
                      context.read<GetProductViewmodel>().subtractUnity();
                    },
                    icon: Icon(Icons.remove),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      context.read<GetProductViewmodel>().addUnity(
                        await context
                            .read<DatabaseService>()
                            .getQuantityFromProduct(widget.product.idProduct),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (checkForm.currentState!.validate()) {
                    if (widget.typeRequest.compareTo("Coger") == 0) {
                      context.read<DatabaseService>().newRegister(
                        widget.product.idProduct,
                        context.read<DatabaseService>().userDatabase!.idUser,
                        "Coger",
                        DateFormat.yMd().add_jm().format(DateTime.now()),
                        int.parse(
                          context
                              .read<GetProductViewmodel>()
                              .quantityController
                              .text,
                        ),
                      );
                      context.read<MessagesViewmodel>().showInformationDialog(
                        context,
                        MediaQuery.of(context).size.width / 4,
                        MediaQuery.of(context).size.height / 4,
                        "Se ha ejecutado correctamente su petición",
                      );
                    } else {
                      context.read<DatabaseService>().newRegister(
                        widget.product.idProduct,
                        context.read<DatabaseService>().userDatabase!.idUser,
                        "Devolver",
                        DateFormat.yMd().add_jm().format(DateTime.now()),
                        int.parse(
                          context
                              .read<GetProductViewmodel>()
                              .quantityController
                              .text,
                        ),
                      );
                      context.read<MessagesViewmodel>().showInformationDialog(
                        context,
                        MediaQuery.of(context).size.width / 4,
                        MediaQuery.of(context).size.height / 4,
                        "Se ha ejecutado correctamente su petición",
                      );
                    }
                  }
                },
                child: (widget.typeRequest.compareTo("Coger") == 0)
                    ? Text("Coger")
                    : Text("Devolver"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
