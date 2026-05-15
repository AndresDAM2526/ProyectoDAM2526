import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/model/databaseProduct.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:proyecto_dam_2526/view/addTypeProduct_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>>? _filteredProducts;
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

  SupabaseService() {
    getAllProducts();
    getTypes();
    getLocations();
    getRoles();
  }

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

  Future<List<Map<String, dynamic>>> getUserData(String email) async {
    try {
      return await supabase
          .from('users')
          .select('id_user,email,username,name,role:role(role),first_sign_in')
          .eq('email', email);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> getFilteredProducts(String? location, String? type) async {
    if (location == null && type != null) {
      try {
        final products = await supabase
            .from('product')
            .select(
              'product,quantity,type!inner(type),location!inner(location)',
            )
            .eq('type.type', type);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
        notifyListeners();
      } catch (e) {
        print("object");
      }
    } else if (type == null && location != null) {
      try {
        final products = await supabase
            .from('product')
            .select(
              'product,quantity,type!inner(type),location!inner(location)',
            )
            .eq('location.location', location);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
        notifyListeners();
      } catch (e) {
        print("object");
      }
    } else {
      try {
        final products = await supabase
            .from('product')
            .select(
              'product,quantity,type!inner(type),location!inner(location)',
            )
            .eq('type.type', type!)
            .eq('location.location', location!);
        _filteredProducts = List<Map<String, dynamic>>.from(products);
        notifyListeners();
      } catch (e) {
        print("object");
      }
    }
  }

  Future<void> getTypes() async {
    try {
      final types = await supabase.from('type').select('id_type,type');
      _types = List<Map<String, dynamic>>.from(types);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteType(
    BuildContext context,
    int idType,
    AppLocalizations l10n,
  ) async {
    try {
      await supabase.from('type').delete().eq('id_type', idType);
      await getTypes();
      notifyListeners();
      return true;
    } on PostgrestException catch (e) {
      if (e.code == '23503') {
        await context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 3,
          l10n.errorBorrado,
        );
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<String>> showTypes() async {
    return types.map((type) => type['type'].toString()).toList();
  }

  Future<void> getLocations() async {
    try {
      final locations = await supabase
          .from('location')
          .select('id_location,location')
          .order('location', ascending: true);
      _locations = List<Map<String, dynamic>>.from(locations);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>> showLocations() async {
    return locations
        .map((location) => location['location'].toString())
        .toList();
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
    return roles.map((rol) => rol['role'].toString()).toList();
  }

  Future<int?> getIdTypeFromNameType(String type) async {
    try {
      final resultQuery = await supabase
          .from('type')
          .select('id_type')
          .eq('type', type)
          .maybeSingle();
      if (resultQuery != null) {
        return resultQuery['id_type'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int?> getIdRoleFromNameRole(String role) async {
    try {
      final resultQuery = await supabase
          .from('role')
          .select('id_role')
          .eq('role', role)
          .maybeSingle();
      if (resultQuery != null) {
        return resultQuery['id_role'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<int?> getIdLocationFromNameLocation(String location) async {
    try {
      final resultQuery = await supabase
          .from('location')
          .select('id_location')
          .eq('location', location)
          .maybeSingle();
      if (resultQuery != null) {
        return resultQuery['id_location'];
      } else {
        return null;
      }
    } catch (e) {}
  }

  Future<int?> getIdTypeRegisterFromNameType(String type) async {
    try {
      final resultQuery = await supabase
          .from('type_register')
          .select('id_type_register')
          .eq('type_register', type)
          .maybeSingle();
      if (resultQuery != null) {
        return resultQuery['id_type_register'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
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
          'id_type': idType,
          'id_location': idLocation,
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
      await supabase.from('product').delete().eq('id_product', idProduct);
      await getAllProducts();
      notifyListeners();
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
          .select('id_product,product,quantity,type(type),location(location)')
          .like('product', '%$name%');
      return List<Map<String, dynamic>>.from(products);
    } catch (e) {
      print("Error al obtener los productos");
    }
  }

  Future<bool> modifyProduct(DatabaseProduct product) async {
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
        await supabase
            .from('product')
            .update({
              'product': product.name,
              'quantity': product.quantity,
              'id_type': idType,
              'id_location': idLocation,
            })
            .eq('id_product', product.idProduct);
        await getAllProducts();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error al actualizar el producto");
      return false;
    }
  }

  Future<bool> newRegister(
    int idProduct,
    String idUser,
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
          'id_type_register': idRegisterType,
          'id_product': idProduct,
          'id_user': idUser,
          'date': DateTime.now().toLocal().toString(),
          'quantity': quantity,
        });
        getAllProducts();
        notifyListeners();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getHistoryRegisterByIdUser(
    String idUser,
  ) async {
    try {
      final registers = await supabase
          .from('register')
          .select('''
          quantity,date,product:id_product ( product,type:id_type(type),location:id_location(location) ), type:id_type_register ( type_register )
        ''')
          .eq('id_user', idUser)
          .order('date', ascending: false);
      return List<Map<String, dynamic>>.from(registers);
    } catch (e) {
      print("Error al obtener los registros");
      print(e);
    }
  }

  Future<bool> addLocation(String location) async {
    try {
      await supabase.from('location').insert({'location': location});
      await getLocations();
      notifyListeners();
      return true;
    } catch (e) {
      print("Error al añadir la localización");
      return false;
    }
  }

  Future<bool> addTypeProduct(String type) async {
    try {
      await supabase.from('type').insert({'type': type});
      await getTypes();
      notifyListeners();
      return true;
    } catch (e) {
      print("Error al añadir el tipo de producto");
      return false;
    }
  }

  Future<bool?> deleteUser(String uuid) async {
    try {
      final deletedUser = await supabase.functions.invoke(
        'delete-user',
        body: {'uuid': uuid},
      );

      if (deletedUser.status == 200) {
        getAllUsers();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteLocation(int idLocation) async {
    try {
      await supabase.from('location').delete().eq('id_location', idLocation);
      await getLocations();
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool?> changePassword(
    String uuid,
    String newPassword,
    BuildContext context,
  ) async {
    try {
      final changePassword = await supabase.functions.invoke(
        'change-password',
        body: {'uuid': uuid, 'new_password': newPassword},
      );
      if (changePassword.status == 200) {
        return true;
      } else {
        return false;
      }
    } on FunctionException catch (e) {
      if (e.status == 400 &&
          e.details.toString().contains(
            "Password should be at least 6 characters",
          )) {
        context.read<MessagesViewmodel>().showErrorDialog(
          context,
          MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height / 3,
          "La contraseña debe tener al menos 6 caracteres",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> updateUser(UserDatabase user, BuildContext context) async {
    try {
      int? idRole = await getIdRoleFromNameRole(user.role);
      final modifiedUser = await supabase.functions.invoke(
        'update-user',
        body: {
          'uuid': user.idUser,
          'email': user.email,
          'username': user.username,
          'name': user.name,
          'idRole': idRole,
        },
      );
      if (context.mounted) {
        if (modifiedUser.status == 200) {
          notifyListeners();
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> getUserByNameOrUsername(
    String value,
  ) async {
    try {
      final users = await supabase
          .from('users')
          .select('*,role(role)')
          .like('username', '%$value%');
      return List<Map<String, dynamic>>.from(users);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>?> getAllUsers() async {
    try {
      final users = await supabase.from('users').select('*,role(role)');
      return List<Map<String, dynamic>>.from(users);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getUuidFromEmail(String email) async {
    try {
      final user = await supabase
          .from('users')
          .select('id_user')
          .eq('email', email);
      return user.first['id_user'];
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int> getQuantityFromIdProduct(int idProduct) async {
    try {
      final result = await supabase
          .from('product')
          .select('quantity')
          .eq('id_product', idProduct)
          .maybeSingle();
      if (result != null) {
        return result['quantity'];
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getHistorial() async {
    try {
      final result = await supabase
          .from('register')
          .select(
            'type_register(type_register),product(product),users(username),date',
          );
      return List<Map<String, dynamic>>.from(result);
    } catch (e) {
      print(e);
      return [];
    }
  }

  bool parseBoolean(String value) {
    if (value.compareTo("TRUE") == 0) {
      return true;
    } else {
      return false;
    }
  }

  void clearFilter() {
    _filteredProducts = null;
    notifyListeners();
  }
}
