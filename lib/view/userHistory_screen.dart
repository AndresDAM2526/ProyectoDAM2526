import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/widgets/historyRegister_widget.dart';
import 'package:sqflite/sqlite_api.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: FutureBuilder(
        future: context.read<DatabaseService>().getHistoryRegisterByIdUser(
          context.read<DatabaseService>().userDatabase!.idUser,
        ),
        builder: (context, snapshot) {
          final history = snapshot.data ?? [];
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: HistoryRegisterWidget(
                  name: history[index]['product'],
                  typeProduct: history[index]['typeProduct'],
                  typeRegister: history[index]['typeRegister'],
                  location: history[index]['location'],
                  quantity: history[index]['quantity'],
                  date: history[index]['date'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
