import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/widgets/userInformation_widget.dart';

class ModifyUserScreen extends StatefulWidget {
  const ModifyUserScreen({super.key});

  @override
  State<ModifyUserScreen> createState() => _ModifyUserScreenState();
}

class _ModifyUserScreenState extends State<ModifyUserScreen> {
  String? search = "";
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.modificarUsuario)),
      body: Column(
        children: [
          Semantics(
            label: l10n.accLabelCampoBuscarUsuario,
            hint: l10n.accHintCampoBuscarUsuario,
            child: Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  label: Text(l10n.introducirUsuarioONombre),
                ),
                onSubmitted: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
          ),
          search!.isEmpty
              ? Expanded(
                  child: Semantics(
                    label: l10n.accLabelResultadoBusqueda,
                    hint: l10n.accHintResultadoBusqueda,
                    child: FutureBuilder(
                      future: context.watch<SupabaseService>().getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Text(l10n.sinResultados);
                        }
                        final foundUsers = snapshot.data;
                        return ListView.builder(
                          itemCount: foundUsers!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child: UserInformationWidget(
                                user: UserDatabase(
                                  idUser: foundUsers[index]['id_user'],
                                  username: foundUsers[index]['username'],
                                  email: foundUsers[index]['email'],
                                  name: foundUsers[index]['name'],
                                  role: foundUsers[index]['role']['role'],
                                  firstLogin:
                                      foundUsers[index]['first_sign_in'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: Semantics(
                    label: l10n.accLabelResultadoBusqueda,
                    hint: l10n.accHintResultadoBusqueda,
                    child: FutureBuilder(
                      future: context
                          .watch<SupabaseService>()
                          .getUserByNameOrUsername(search!),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(l10n.sinResultados);
                        }
                        final foundUsers = snapshot.data;
                        return ListView.builder(
                          itemCount: foundUsers!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.darkScaffold,
                              ),
                              margin: EdgeInsets.all(5),
                              child: UserInformationWidget(
                                user: UserDatabase(
                                  idUser: foundUsers[index]['id_user'],
                                  username: foundUsers[index]['username'],
                                  email: foundUsers[index]['email'],
                                  name: foundUsers[index]['name'],
                                  role: foundUsers[index]['role']['role'],
                                  firstLogin:
                                      foundUsers[index]['first_sign_in'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
