import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';

class GetProductWidget extends StatefulWidget {
  RequestProduct product;
  int maxQuantity;
  GetProductWidget({
    super.key,
    required this.product,
    required this.maxQuantity,
  });

  @override
  State<GetProductWidget> createState() => _GetProductWidgetState();
}

class _GetProductWidgetState extends State<GetProductWidget> {
  int userQuantity = 0;
  bool? readOnlyTextForm = false;
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Obtener producto"))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Producto : ${widget.product.name}"),
                Text("Tipo elegido: ${widget.product.type}"),
                Text("Ubicación elegido: ${widget.product.location}"),
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
                  label: Text("Unidades disponibles: ${widget.maxQuantity}"),
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
                    
                  }
                },
                child: Text("Enviar"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
