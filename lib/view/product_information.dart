import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/Product.dart';

class ProductInformation extends StatelessWidget {
  Product product;
  ProductInformation({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Nombre"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 70,
                      right: 70,
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
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Tipo"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 70,
                      right: 70,
                      bottom: 10,
                    ),
                    child: Text(product.type),
                  ),
                ],
              ),
            ),Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Ubicación"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 70,
                      right: 70,
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
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Cantidad"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 1),
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
    );
  }
}
