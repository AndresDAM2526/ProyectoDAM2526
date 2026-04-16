import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/widgets/errorMessage_widget.dart';
import 'package:proyecto_dam_2526/widgets/informationMessage_widget.dart';

class MessagesViewmodel extends ChangeNotifier {
  void showErrorDialog(
    BuildContext context,
    double width,
    double height,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: width,
            height: height,
            child: ErrorMessageWidget(message: message),
          ),
        );
      },
    );
  }

  void showInformationDialog(
    BuildContext context,
    double width,
    double height,
    String message,
  ) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: width,
            height: height,
            child: InformationMessageWidget(message: message),
          ),
        );
      },
    );
  }
}
