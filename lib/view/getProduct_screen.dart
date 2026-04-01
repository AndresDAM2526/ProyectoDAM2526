import 'package:flutter/material.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Get product"),),);
  }
}