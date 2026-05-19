import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';

import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  List<String> statusList = ['Temporal', 'Definitivo'];
  String? status;
  int userQuantity = 0;
  bool? readOnlyTextForm = false;
  final checkForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: (widget.typeRequest.compareTo("Coger") == 0)
              ? Text(l10n.obtenerProducto)
              : Text(l10n.devolverProducto),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 10, bottom: 15, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${l10n.nombre}: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${l10n.tipo}: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.product.type),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${l10n.ubicacion}: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.product.location),
                    ],
                  ),
                  ?(widget.typeRequest.compareTo("Coger") == 0)
                      ? Text(
                          "${l10n.duracion}:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                  ?(widget.typeRequest.compareTo("Coger") == 0)
                      ? Container(
                          margin: EdgeInsets.all(5),
                          child: RadioGroup(
                            groupValue: status,
                            onChanged: (value) {
                              setState(() {
                                status = value;
                              });
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Radio(
                                    value: "Temporal",
                                    activeColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                  title: Text(l10n.temporal),
                                ),
                                ListTile(
                                  leading: Radio(
                                    value: "Definitivo",
                                    activeColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                  title: Text(l10n.definitivo),
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                  ?(widget.typeRequest.compareTo("Coger") == 0)
                      ? Container(
                          margin: EdgeInsets.all(5),
                          child: TextField(
                            controller: context
                                .read<GetProductViewmodel>()
                                .descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              label: Text(l10n.descripcion),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                        )
                      : null,
                  ?(widget.typeRequest.compareTo("Coger") == 0)
                      ? Text(
                          "${l10n.cantidad}:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ],
              ),
            ),

            ?(widget.typeRequest.compareTo("Coger") == 0)
                ? Row(
                    children: [
                      Checkbox(
                        value: readOnlyTextForm,
                        onChanged: (value) {
                          setState(() {
                            readOnlyTextForm = value!;
                            context.read<GetProductViewmodel>().clearForm();
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          l10n.cantidadManual,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                : null,

            Form(
              key: checkForm,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 40,
                  right: 40,
                  bottom: 25,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  readOnly: (widget.typeRequest.compareTo("Coger") == 0)
                      ? !readOnlyTextForm!
                      : false,
                  controller: context
                      .read<GetProductViewmodel>()
                      .quantityController,
                  validator: (value) =>
                      (widget.typeRequest.compareTo("Coger") == 0)
                      ? context
                            .read<GetProductViewmodel>()
                            .checkQuantityGetProduct(
                              value,
                              l10n,
                              widget.maxQuantity!,
                            )
                      : context
                            .read<GetProductViewmodel>()
                            .checkQuantityReturnProduct(value, l10n),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorMaxLines: 2,
                    label: (widget.typeRequest.compareTo("Coger") == 0)
                        ? Text(
                            "${l10n.unidadesDisponibles}: ${widget.maxQuantity}",
                          )
                        : Text(l10n.unidadesDevolver),
                    prefixIcon:
                        (widget.typeRequest.compareTo("Coger") == 0 &&
                            readOnlyTextForm != true)
                        ? IconButton(
                            onPressed: () {
                              context
                                  .read<GetProductViewmodel>()
                                  .subtractUnity();
                            },
                            icon: Icon(Icons.remove),
                          )
                        : null,

                    suffixIcon:
                        (widget.typeRequest.compareTo("Coger") == 0 &&
                            readOnlyTextForm != true)
                        ? IconButton(
                            onPressed: () async {
                              context.read<GetProductViewmodel>().addUnity(
                                await context
                                    .read<SupabaseService>()
                                    .getQuantityFromIdProduct(
                                      widget.product.idProduct,
                                    ),
                              );
                            },
                            icon: Icon(Icons.add),
                          )
                        : null,
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
                        context.read<SupabaseService>().newRegister(
                          widget.product.idProduct,
                          context.read<AuthService>().userDatabase!.idUser,
                          "Coger",
                          DateFormat.yMd().add_jm().format(DateTime.now()),
                          int.parse(
                            context
                                .read<GetProductViewmodel>()
                                .quantityController
                                .text,
                          ),
                          widget.product.location,
                          status,
                          context
                              .read<GetProductViewmodel>()
                              .descriptionController
                              .text,
                        );
                      } else {
                        context.read<SupabaseService>().newRegister(
                          widget.product.idProduct,
                          context.read<AuthService>().userDatabase!.idUser,
                          "Devolver",
                          DateFormat.yMd().add_jm().format(DateTime.now()),
                          int.parse(
                            context
                                .read<GetProductViewmodel>()
                                .quantityController
                                .text,
                          ),
                          widget.product.location,
                          null,
                          null,
                        );
                      }
                      Navigator.pop(context, true);
                    }
                  },
                  child: (widget.typeRequest.compareTo("Coger") == 0)
                      ? Text(l10n.obtener)
                      : Text(l10n.devolverProducto),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
