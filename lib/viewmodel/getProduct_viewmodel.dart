import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/requestProduct.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/transactions_widget.dart';

class GetProductViewmodel extends ChangeNotifier {
  int userQuantity = 0;
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? checkQuantityGetProduct(
    String? value,
    AppLocalizations l10n,
    int maxQuantity,
  ) {
    if (value == null || value.isEmpty) {
      return l10n.campoVacio;
    } else if (int.tryParse(value) == null) {
      return l10n.formatoIncorrecto;
    }
    int quantity = int.parse(value);
    if (quantity == 0) {
      return l10n.cantidadCorrecta;
    } else if (quantity < 0) {
      return l10n.cantidadNegativa;
    } else if (quantity > maxQuantity) {
      return l10n.cantidadSuperior;
    }
    return null;
  }

  String? checkQuantityReturnProduct(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.campoVacio;
    } else if (int.tryParse(value) == null) {
      return l10n.formatoIncorrecto;
    }
    int quantity = int.parse(value);
    if (quantity == 0) {
      return l10n.cantidadCorrecta;
    } else if (quantity < 0) {
      return l10n.cantidadNegativa;
    }
    return null;
  }

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
    descriptionController.clear();
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
            width: MediaQuery.of(context).size.width,
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
        MediaQuery.of(context).size.width,
        (context.read<ThemeViewmodel>().fontSize < 24)
            ? MediaQuery.of(context).size.height / 3
            : MediaQuery.of(context).size.height * 0.4,
        l10n.peticionCorrecta,
      );
      context.read<GetProductViewmodel>().clearForm();
    } else {
      context.read<GetProductViewmodel>().clearForm();
    }
  }
}
