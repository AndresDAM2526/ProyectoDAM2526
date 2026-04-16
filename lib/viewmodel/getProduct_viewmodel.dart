import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/transactions_widget.dart';

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

  void clearForm() {
    quantityController.clear();
    notifyListeners();
  }

  void showGetProductWidgetDialog(
    BuildContext context,
    RequestProduct product,
    int maxQuantity,
    String typeRequest,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: (typeRequest.compareTo("Coger") == 0)
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height / 2,
            child: Transactions(
              product: product,
              maxQuantity: maxQuantity,
              typeRequest: typeRequest,
            ),
          ),
        );
      },
    );
    if (result == true) {
      context.read<MessagesViewmodel>().showInformationDialog(
        context,
        MediaQuery.of(context).size.width / 2,
        MediaQuery.of(context).size.height / 4,
        "Se ha ejecutado correctamente su petición",
      );
    }
  }
}
