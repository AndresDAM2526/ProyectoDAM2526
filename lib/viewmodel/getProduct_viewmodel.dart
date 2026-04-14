import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/widgets/getProduct_widget.dart';

class GetProductViewmodel extends ChangeNotifier {
  int userQuantity = 0;
  TextEditingController quantityController = TextEditingController();

  String? checkQuantity(String? value) => (value == null || value.isEmpty)
      ? "Campo vacio"
      : (int.tryParse(value) == null)
      ? "Formato incorrecto"
      : (int.parse(value) == 0)
      ? "Introduzca una cantidad correcta"
      : null;

  void addUnity(int maxQuantity) {
    if (userQuantity < maxQuantity) {
      userQuantity++;
      quantityController.text = userQuantity.toString();
    }
    notifyListeners();
  }

  void subtractUnity() {
    if (userQuantity > 0) {
      userQuantity--;
      quantityController.text = userQuantity.toString();
    }
    notifyListeners();
  }

  void showGetProductWidgetDialog(
    BuildContext context,
    RequestProduct product,
    int maxQuantity,
  ) async {
    int? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.height / 2,
            child: GetProductWidget(product: product, maxQuantity: maxQuantity),
          ),
        );
      },
    );
  }
}
