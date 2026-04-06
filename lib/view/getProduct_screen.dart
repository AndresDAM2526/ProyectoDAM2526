import 'package:flutter/material.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Coger producto")),
              ElevatedButton(
                onPressed: () {},
                child: Text("Devolver producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
