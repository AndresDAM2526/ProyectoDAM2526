import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/model/NewUser.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:proyecto_dam_2526/model/user.dart';

class AuthService extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  UserDatabase? _userDatabase;
  UserDatabase? get userDatabase => _userDatabase;

  Future<bool?> createNewUser(NewUser user, BuildContext context) async {
    try {
      final userAdded = await supabase.functions.invoke(
        'create-user',
        body: {
          'email': user.email,
          'username': user.username,
          'name': user.name,
          'password': user.password,
          'idRole': user.idRole,
        },
      );
      if (context.mounted) {
        if (userAdded.status == 200) {
          return true;
        }
      } else {
        return false;
      }
    } on FunctionException catch (e) {
      final details = e.details['error'].toString();
      if (details.contains(
        "A user with this email address has already been registered",
      )) {
        context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height / 3,
          "El email indicado ya ha sido utilizado",
        );
        return false;
      }
    }
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
      bool? firstSignin;
      List<Map<String, dynamic>> dataUser = await context
          .read<SupabaseService>()
          .getUserData(email);
      if (dataUser.isNotEmpty) {
        if (dataUser.first['first_sign_in'] == "TRUE") {
          firstSignin = true;
        } else {
          firstSignin = false;
        }
        updateSession(
          UserDatabase(
            idUser: dataUser.first['id_user'],
            email: dataUser.first['email'],
            name: dataUser.first['name'],
            username: dataUser.first['username'],
            role: dataUser.first['role']['role'],
            firstLogin: firstSignin,
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
    }
  }
}
