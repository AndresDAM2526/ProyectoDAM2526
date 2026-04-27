
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:proyecto_dam_2526/model/user.dart';

class AuthService extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  Future<void> createNewUser(User newUser,BuildContext context) async{
    await supabase.functions.invoke('create-user',body: {
      'email':newUser.email,
      'username':newUser.username,
      'name':newUser.name,
      'password':newUser.password
    });
  }
}
