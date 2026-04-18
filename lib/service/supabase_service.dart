import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  Future<void> getAllProducts() async {
    try {
      final data = await supabase
          .from('product')
          .select('product,quantity,type(type),location(location)');
      _products = List<Map<String, dynamic>>.from(data);
      notifyListeners();
    } catch (e) {
      print("Error cargando los usuarios");
    }
  }
}
