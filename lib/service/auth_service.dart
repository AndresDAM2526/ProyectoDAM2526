import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/main.dart';
import 'package:proyecto_dam_2526/model/newUser.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/view/newUserPassword_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class AuthService extends ChangeNotifier {
  int selectedScreen = 0;
  final supabase = Supabase.instance.client;
  UserDatabase? _userDatabase;
  UserDatabase? get userDatabase => _userDatabase;

  Future<bool?> createNewUser(
    NewUser user,
    BuildContext context,
    AppLocalizations l10n,
  ) async {
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
          l10n.emailUsado,
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
    selectedScreen = 0;
    notifyListeners();
  }

  Future<void> checkLogin(
    String email,
    String password,
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      bool firstSignin = false;
      List<Map<String, dynamic>> dataUser = await context
          .read<SupabaseService>()
          .getUserData(email);
      if (dataUser.isNotEmpty) {
        if (dataUser.first['first_sign_in'].toString().compareTo("true") == 0) {
          String? idUser = await context
              .read<SupabaseService>()
              .getUuidFromEmail(email);
          if (idUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NewUserPassword(idUser: idUser, email: email),
              ),
            );
            context.read<LoginFormViewmodel>().clearForm();
          }
        } else {
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
          context.read<LoginFormViewmodel>().clearForm();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        }
      }
      notifyListeners();
    } on AuthException catch (e) {
      if (e.code!.contains("invalid_credentials")) {
        context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 3,
          l10n.inicioSesionIncorrecto,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updatePassword(
    String idUser,
    String email,
    String password,
    String newPassword,
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      final updatedPassword = await supabase.functions.invoke(
        'new-user-change-password',
        body: {
          'email': email,
          'current_password': password,
          'new_password': newPassword,
          'id_user': idUser,
        },
      );
      if (updatedPassword.status == 200) {
        await supabase.auth.signOut();
        notifyListeners();
        return true;
      }
      return false;
    } on FunctionException catch (e) {
      if (e.status == 401) {
        context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width / 2,
          (context.read<ThemeViewmodel>().fontSize < 24)
              ? MediaQuery.of(context).size.height *0.4
              : MediaQuery.of(context).size.height * 0.4,
          l10n.contrasenaActualIncorrecta,
        );
        return false;
      }
      if (e.status == 400) {
        print("Entra aqui error 400");
        print(e.details);
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
