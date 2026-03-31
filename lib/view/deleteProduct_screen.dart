import 'package:flutter/material.dart';

class DeleteproductScreen extends StatefulWidget {
  const DeleteproductScreen({super.key});

  @override
  State<DeleteproductScreen> createState() => _DeleteproductScreenState();
}

class _DeleteproductScreenState extends State<DeleteproductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Borrar producto"))),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  label: Center(child: Text("Introduzca el nombre")),
                ),
                onSubmitted: (value) => print(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
