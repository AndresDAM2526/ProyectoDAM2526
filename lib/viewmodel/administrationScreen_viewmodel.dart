import 'package:flutter/material.dart';

class AdministrationscreenViewmodel extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  String? checkLocation(String value) =>
      (value == null || value.isEmpty) ? "Campo vacio" : "";
  void showAddLocationDialog(BuildContext context) {}
}
