import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:proyecto_dam_2526/model/user.dart';

class AuthService extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  UserDatabase? _userDatabase;
  UserDatabase? get userDatabase => _userDatabase;

  Future<void> createNewUser(User newUser, BuildContext context) async {
    await supabase.functions.invoke(
      'create-user',
      body: {
        'email': newUser.email,
        'username': newUser.username,
        'name': newUser.name,
        'password': newUser.password,
      },
    );
  }

  Future<void> updateSession(UserDatabase user) async {
    _userDatabase = user;
    notifyListeners();
  }

  Future<void> logOut() async {
    await supabase.auth.signOut();
    _userDatabase = null;
    notifyListeners();
  }

  Future<void> checkLogin(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      List<Map<String, dynamic>> dataUser = await context
          .read<SupabaseService>()
          .getUserData(email);
      if (dataUser.isNotEmpty) {
        print("Entra aqui");
        int firstLogin = -1;
        if (dataUser.first['first_sign_in'] == "TRUE") {
          firstLogin = 1;
        } else {
          firstLogin = 0;
        }
        updateSession(
          UserDatabase(
            idUser: dataUser.first['id_user'],
            name: dataUser.first['name'],
            username: dataUser.first['username'],
            role: dataUser.first['role']['role'],
            firstLogin: firstLogin,
          ),
        );
        print(_userDatabase!.role);
      }
      notifyListeners();
    } on AuthException catch (e) {
      if (e.code!.contains("invalid_credentials")) {
        context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height / 4,
          "Usuario y/o contraseña incorrectos",
        );
      }
    }on SocketException catch(e){
      context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height / 4,
          "Compruebe si el dispositivo tiene conexión a Internet",
        );
    }
  }
}
