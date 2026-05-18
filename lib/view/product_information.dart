import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';

class ProductInformation extends StatelessWidget {
  Product product;
  ProductInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(l10n.nombre),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                        bottom: 10,
                      ),
                      child: Text(product.name),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text("Tipo"),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                        bottom: 10,
                      ),
                      child: Text(product.type),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(l10n.ubicacion),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 40,
                        right: 40,
                        bottom: 10,
                      ),
                      child: Text(product.location),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(l10n.cantidad),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 70,
                        right: 70,
                        bottom: 10,
                      ),
                      child: Text(product.quantity.toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
