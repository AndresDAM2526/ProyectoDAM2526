import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/transactions_widget.dart';

class GetProductViewmodel extends ChangeNotifier {
  int userQuantity = 0;
  TextEditingController quantityController = TextEditingController();

  String? checkQuantity(String? value, AppLocalizations l10n) =>
      (value == null || value.isEmpty)
      ? l10n.campoVacio
      : (int.tryParse(value) == null)
      ? l10n.formatoIncorrecto
      : (int.parse(value) == 0)
      ? l10n.cantidadCorrecta
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
    userQuantity = 0;
    quantityController.clear();
    notifyListeners();
  }

  void showGetProductWidgetDialog(
    BuildContext context,
    AppLocalizations l10n,
    RequestProduct product,
    int maxQuantity,
    String typeRequest,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height,
            width: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width,
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
        l10n.peticionCorrecta,
      );
    } else {
      context.read<GetProductViewmodel>().clearForm();
    }
  }
}
