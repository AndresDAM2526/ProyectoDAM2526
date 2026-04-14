import 'package:flutter/material.dart';

class InformationMessageWidget extends StatelessWidget {
  String message;
  InformationMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text("Informacion")),
        Container(width: double.infinity, height: 3, color: Colors.black),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(message)),
      ],
    );
  }
}
