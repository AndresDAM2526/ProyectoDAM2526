import 'package:flutter/material.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/view/addTypeProduct_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>>? _filteredProducts = null;
  List<Map<String, dynamic>>? get filteredProducts => _filteredProducts;

  List<Map<String, dynamic>> _types = [];
  List<Map<String, dynamic>> get types => _types;

  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> get locations => _locations;

  List<Map<String, dynamic>> _roles = [];
  List<Map<String, dynamic>> get roles => _roles;

  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> get users => _users;

  List<Map<String, dynamic>> _historyRegister = [];
  List<Map<String, dynamic>> get historyRegister => _historyRegister;

  Future<void> getAllProducts() async {
    try {
      final products = await supabase
          .from('product')
          .select('product,quantity,type(type),location(location)');
      _products = List<Map<String, dynamic>>.from(products);
      notifyListeners();
    } catch (e) {
      print("Error cargando los productos");
    }
  }

  Future<void> getFilteredProducts(String? location, String? type) async {
    if (location == null && type != null) {
      try {
        final products = await supabase
            .from('product')
            .select('product,quantity,type(type),location(location)')
            .eq('type.type', type);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
      } catch (e) {
        print("object");
      }
    } else if (type == null && location != null) {
      try {
        final products = await supabase
            .from('product')
            .select('product,quantity,type(type),location(location)')
            .eq('location.location', location);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
      } catch (e) {
        print("object");
      }
    } else {
      try {
        final products = await supabase
            .from('product')
            .select('product,quantity,type(type),location(location)')
            .eq('type.type.', type!)
            .eq('location.location.', location!);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
        notifyListeners();
      } catch (e) {
        print("object");
      }
    }
  }

  Future<void> getType() async {
    try {
      final types = await supabase.from('type').select('type');
      _types = List<Map<String, dynamic>>.from(types);
      notifyListeners();
    } catch (e) {
      print("object");
    }
  }

  Future<List<String>> showTypes() async {
    return types.map((type) => type.toString()).toList();
  }

  Future<void> getLocations() async {
    try {
      final locations = supabase.from('location').select('location');
      _locations = List<Map<String, dynamic>>.from(products);
      notifyListeners();
    } catch (e) {
      print("object");
    }
  }

  Future<List<String>> showLocations() async {
    return locations.map((location) => location.toString()).toList();
  }

  Future<void> getRoles() async {
    try {
      final roles = await supabase.from('role').select('role');
      _roles = List<Map<String, dynamic>>.from(roles);
      notifyListeners();
    } catch (e) {
      print("object");
    }
  }

  Future<List<String>> showRoles() async {
    return roles.map((rol) => rol.toString()).toList();
  }

  Future<int?> getIdTypeFromNameType(String type) async {
    try {
      final resultQuery = await supabase
          .from('type')
          .select('idtype')
          .eq('type', type)
          .maybeSingle();
      if (resultQuery != null) {
        return int.parse(resultQuery['idtype']);
      } else {
        return null;
      }
    } catch (e) {
      print("object");
    }
  }

  Future<int?> getIdLocationFromNameLocation(String location) async {
    try {
      final resultQuery = await supabase
          .from('location')
          .select('idlocation')
          .eq('location', location)
          .maybeSingle();
      if (resultQuery != null) {
        return int.parse(resultQuery['idlocation']);
      } else {
        return null;
      }
    } catch (e) {}
  }

  Future<int?> getIdTypeRegisterFromNameType(String type) async {
    try {
      final resultQuery = await supabase
          .from('typeregister')
          .select('idtyperegister')
          .eq('typeregister', type)
          .maybeSingle();
      if (resultQuery != null) {
        return int.parse(resultQuery['idtyperegister']);
      } else {
        return null;
      }
    } catch (e) {}
  }

  Future<bool> addProduct(Product product) async {
    try {
      int? idType = await getIdTypeFromNameType(product.type);
      int? idLocation = await getIdLocationFromNameLocation(product.location);
      if (idType == null) {
        print("Error al obtener el identificador del tipo");
        return false;
      } else if (idLocation == null) {
        print("Error al obtener el identificador de la ubicación");
        return false;
      } else {
        await supabase.from('product').insert({
          'product': product.name,
          'quantity': product.quantity,
          'idtype': idType,
          'idlocation': idLocation,
        });
        getAllProducts();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("object");
      return false;
    }
  }

  Future<bool> deleteProduct(int idProduct) async {
    try {
      await supabase.from('product').delete().eq('idproduct', idProduct);
      return true;
    } catch (e) {
      print("Error al borrar el producto");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getProductsFromName(String name) async {
    try {
      final products = await supabase
          .from('product')
          .select('idproduct,product,quantity,type(type),location(location)')
          .like('product', '%$name%');
      return List<Map<String, dynamic>>.from(products);
    } catch (e) {
      print("Error al obtener los productos");
    }
  }

  Future<bool> modifyProduct(Product product) async {
    try {
      int? idType = await getIdTypeFromNameType(product.type);
      int? idLocation = await getIdLocationFromNameLocation(product.location);
      if (idType == null) {
        print("Error al obtener el identificador del tipo");
        return false;
      } else if (idLocation == null) {
        print("Error al obtener el identificador de la ubicación");
        return false;
      } else {
        await supabase.from('product').update({
          'product': product.name,
          'quantity': product.quantity,
          'idtype': idType,
          'idlocation': idLocation,
        });
        return true;
      }
    } catch (e) {
      print("Error al actualizar el producto");
      return false;
    }
  }

  Future<bool> newRegister(
    int idProduct,
    int idUser,
    String registerType,
    String date,
    int quantity,
  ) async {
    try {
      int? idRegisterType = await getIdTypeRegisterFromNameType(registerType);
      if (idRegisterType == null) {
        print("Error al obtener el identificador del tipo de registro");
        return false;
      } else {
        await supabase.from('register').insert({
          'idtyperegister': idRegisterType,
          'idproduct': idProduct,
          'idUser': idUser,
          'date': DateTime.now().toLocal(),
          'quantity': quantity,
        });
        getAllProducts();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error al crear un nuevo registro");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getHistoryRegisterByIdUser(
    int idUser,
  ) async {
    try {
      final registers = await supabase
          .from('register')
          .select('product(product),type(type),typeregister(type),quantity')
          .eq('iduser', idUser);
      return List<Map<String, dynamic>>.from(registers);
    } catch (e) {
      print("Error al obtener los registros");
    }
  }

  Future<bool> addLocation(String location) async {
    try {
      await supabase.from('location').insert({'location': location});
      return true;
    } catch (e) {
      print("Error al añadir la localización");
      return false;
    }
  }

  Future<bool> addTypeProduct(String type) async {
    try {
      await supabase.from('type').insert({'type': type});
      return true;
    } catch (e) {
      print("Error al añadir el tipo de producto");
      return false;
    }
  }
}
