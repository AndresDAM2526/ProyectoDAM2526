import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/DatabaseProduct.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/searchProductFrom_viewmodel.dart';

class ModifyProductScreen extends StatefulWidget {
  DatabaseProduct product;
  ModifyProductScreen({super.key, required this.product});

  @override
  State<ModifyProductScreen> createState() => _ModifyProductScreenState();
}

class _ModifyProductScreenState extends State<ModifyProductScreen> {
  final checkForm = GlobalKey<FormState>();
  List<Widget> elements = [
    Text("Nombre"),
    Text("Tipo"),
    Text("Ubicación"),
    Text("Cantidad"),
    Text("Todo"),
  ];
  final List<bool> _selectedItem = [false, false, false, false, false];
  String? name = "";
  String? selectedType = "";
  String? selectedLocation = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Modificar producto"))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Seleccione que desea modificar"),
            Center(
              child: ToggleButtons(
                isSelected: _selectedItem,
                children: elements,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _selectedItem.length; i++) {
                      _selectedItem[i] = (i == index);
                      //context.read<ModifyProductformViewmodel>().typeDropDown.currentState!.reset();
                      //context.read<ModifyProductformViewmodel>().locationDropDown.currentState!.reset();
                    }
                  });
                },
              ),
            ),
            _selectedItem[0]
                ? Form(
                    key: checkForm,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            validator: (value) => context
                                .read<ModifyProductformViewmodel>()
                                .checkName(value),
                            decoration: InputDecoration(
                              label: Text("Introduzca el nuevo nombre"),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (checkForm.currentState!.validate()) {
                              await context
                                  .read<DatabaseService>()
                                  .modifyNameProduct(
                                    widget.product.idProduct,
                                    context
                                        .read<ModifyProductformViewmodel>()
                                        .nameController
                                        .text,
                                  );
                            }
                            Navigator.pop(context, true);
                          },
                          child: Text("Enviar"),
                        ),
                      ],
                    ),
                  )
                : _selectedItem[1]
                ? Form(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: FutureBuilder(
                            future: context.read<DatabaseService>().showTypes(),
                            builder: (context, snapshot) {
                              final types = snapshot.data ?? [];
                              return DropdownButtonFormField(
                                items: types
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(type),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedType = value!;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                      ],
                    ),
                  )
                : _selectedItem[2]
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: FutureBuilder(
                          future: context
                              .read<DatabaseService>()
                              .showLocations(),
                          builder: (context, snapshot) {
                            final locations = snapshot.data ?? [];
                            return DropdownButtonFormField(
                              items: locations
                                  .map(
                                    (location) => DropdownMenuItem(
                                      value: location,
                                      child: Text(location),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                    ],
                  )
                : _selectedItem[3]
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Introduzca la nueva cantidad "),
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Introduzca el nombre"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Introduzca el tipo"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Introduzca la ubicación"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Introduzca la cantidad"),
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Enviar")),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
