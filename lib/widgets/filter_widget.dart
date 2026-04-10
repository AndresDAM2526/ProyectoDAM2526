import 'dart:math';

import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> elementos = ["Primer boton", "Segundo botón"];
  String? selectedRadio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RadioGroup<String>(
        groupValue: selectedRadio,
        onChanged: (value) {
          setState(() {
            selectedRadio=value;
          });
          print(selectedRadio);
        },
        child: ListView.builder(
          itemCount: elementos.length,
          itemBuilder: (context, index) {
            return SizedBox(
              child: ListTile(
                leading: Radio(value: elementos[index]),
                title: Text(elementos[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
