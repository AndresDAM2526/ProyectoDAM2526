import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/widgets/historyRegister_widget.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.historial)),
      body: FutureBuilder(
        future: context.watch<SupabaseService>().getHistoryRegisterByIdUser(
          context.watch<AuthService>().userDatabase!.idUser,
        ),
        builder: (context, snapshot) {
          final history = snapshot.data ?? [];
          if (history.isEmpty) {
            return Center(child: Text(l10n.sinResultados));
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: HistoryRegisterWidget(
                  name: history[index]['product']['product'],
                  typeProduct: history[index]['product']['type']['type'],
                  typeRegister: history[index]['type']['type_register'],
                  location: history[index]['product']['location']['location'],
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
