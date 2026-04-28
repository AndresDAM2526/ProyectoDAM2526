import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proyecto_dam_2526/model/DatabaseProduct.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:proyecto_dam_2526/model/userDatabase.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends ChangeNotifier {
  late final Future<Database> database;

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
  UserDatabase? _userDatabase;
  UserDatabase? get userDatabase => _userDatabase;

  DatabaseService() {
    database = _loadDatabase();
    getAllProducts();
    getTypes();
    getLocations();
    getRoles();
  }

  Future<Database> _loadDatabase() async {
    final dbPath = join(
      await databaseFactory.getDatabasesPath(),
      'gestion_inventario.db',
    );
    print("Creado en $dbPath");
    final database = await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE IF NOT EXISTS type(
	                              idType INTEGER PRIMARY KEY AUTOINCREMENT,
	                              type TEXT NOT NULL
                          )''');
          await db.execute('''CREATE TABLE IF NOT EXISTS location(
                            idLocation INTEGER PRIMARY KEY AUTOINCREMENT,
                            location TEXT NOT NULL
                          )''');
          await db.execute('''CREATE TABLE IF NOT EXISTS product(
                            idProduct INTEGER PRIMARY KEY AUTOINCREMENT,
                            product TEXT NOT NULL,
                            quantity TEXT NOT NULL,
                            idType INTEGER NOT NULL,
                            idLocation INTEGER NOT NULL,

                            FOREIGN KEY (idType) REFERENCES type(idType) ON DELETE CASCADE ON UPDATE CASCADE,
                            FOREIGN KEY (idLocation) REFERENCES location(idLocation) ON DELETE CASCADE ON UPDATE CASCADE
                          )''');
          await db.execute('''CREATE TABLE IF NOT EXISTS role(
                            idRole INTEGER PRIMARY KEY AUTOINCREMENT,
                            role TEXT NOT NULL
                          )''');

          await db.execute('''CREATE TABLE IF NOT EXISTS user(
                            idUser INTEGER PRIMARY KEY AUTOINCREMENT,
                            username TEXT NOT NULL,
                            password TEXT NOT NULL,
                            name TEXT NOT NULL,
                            idRole INTEGER NOT NULL,
                            firstSignin INTEGER, 

                            FOREIGN KEY (idRole) REFERENCES rol(idRole) ON DELETE CASCADE ON UPDATE CASCADE
                          )''');

          await db.execute('''CREATE TABLE IF NOT EXISTS registerType(
                            idType INTEGER PRIMARY KEY AUTOINCREMENT,
                            type TEXT NOT NULL
                          )''');

          await db.execute('''CREATE TABLE IF NOT EXISTS register(
                            idRegister INTEGER PRIMARY KEY AUTOINCREMENT,
                            idProduct INTEGER NOT NULL,
                            idUser INTEGER NOT NULL,
                            idRegisterType INTEGER NOT NULL,
                            date TEXT NOT NULL,
                            quantity INTEGER NOT NULL,

                            FOREIGN KEY (idProduct) REFERENCES product(idProduct) ON DELETE CASCADE ON UPDATE CASCADE,
                            FOREIGN KEY (idUser) REFERENCES user(idUser) ON DELETE CASCADE ON UPDATE CASCADE,
                            FOREIGN KEY (idRegisterType) REFERENCES registerType(idType) ON DELETE CASCADE ON UPDATE CASCADE
                          )''');
          await db.insert('role', {'role': 'Admin'});
          await db.insert('role', {'role': 'Profesor'});
          await db.insert('role', {'role': 'Alumno'});

          await db.insert('user', {
            'username': 'andres',
            'password': 'andres',
            'name': 'Andres Correa Garcia',
            'idRole': '1',
            'firstSignin': '0',
          });

          await db.insert('user', {
            'username': 'juan',
            'password': 'juan',
            'name': 'Juan Perez Dominguez',
            'idRole': '3',
            'firstSignin': '1',
          });

          await db.insert('type', {'type': 'Memoria'});
          await db.insert('type', {'type': 'Cable'});
          await db.insert('type', {'type': 'Ordenador'});
          await db.insert('type', {'type': 'Períferico'});

          await db.insert('location', {'location': 'Almacen-01'});
          await db.insert('location', {'location': 'Almacen-02'});

          await db.insert('registerType', {'type': 'Coger'});
          await db.insert('registerType', {'type': 'Devolver'});
        },
      ),
    );
    return database;
  }

  Future<void> getAllUsers() async {
    final db = await database;
    _users = await db.rawQuery(
      '''SELECT u.username,u.name,r.role as role FROM user u
                                INNER JOIN role r ON r.idRole=u.idRole''',
    );
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getUserByNameOrUsername(
    String? value,
  ) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      '''SELECT u.idUser,u.username,u.name,r.role as role FROM user u
                          INNER JOIN role r on u.idRole=r.idRole
                          WHERE u.username LIKE ? OR u.name LIKE ?
                    ''',
      ['%$value%', '%$value%'],
    );
    notifyListeners();
    return result;
  }

  Future<void> addUser(User user) async {
    final db = await database;
    int idRole = await getIdRoleFromNameRole(user.role);
    await db.insert('user', {
      'username': user.username,
      'name': user.name,
      'password': user.password,
      'idRole': idRole,
    });
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    final db = await database;
    _products = await db.rawQuery(
      '''SELECT p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation''',
    );
    notifyListeners();
  }

  Future<void> getFilteredProducts(String? location, String? type) async {
    final db = await database;
    if (location == null && type != null) {
      _filteredProducts = await db.rawQuery(
        '''SELECT p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation
      WHERE t.type=?''',
        [type],
      );
    } else if (type == null && location != null) {
      _filteredProducts = await db.rawQuery(
        '''SELECT p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation
      WHERE l.location=?''',
        [location],
      );
    } else {
      _filteredProducts = await db.rawQuery(
        '''SELECT p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation
      WHERE l.location=? AND t.type=?''',
        [location, type],
      );
    }
    notifyListeners();
  }

  Future<void> getTypes() async {
    final db = await database;
    _types = await db.query('type', columns: ['type']);
    notifyListeners();
  }

  Future<List<String>> showTypes() async {
    return types.map((type) => type['type'].toString()).toList();
  }

  Future<void> getLocations() async {
    final db = await database;
    _locations = await db.query('location', columns: ['location']);
    notifyListeners();
  }

  Future<List<String>> showLocations() async {
    return locations
        .map((location) => location['location'].toString())
        .toList();
  }

  Future<void> getRoles() async {
    final db = await database;
    _roles = await db.query('role', columns: ['role']);
    notifyListeners();
  }

  Future<List<String>> showRoles() async {
    return roles.map((rol) => rol['role'].toString()).toList();
  }

  Future<int> getIdTypeFromNameType(String type) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'type',
      columns: ['idType'],
      where: 'type=?',
      whereArgs: [type],
    );
    return result.first['idType'];
  }

  Future<int> getIdLocationFromNameLocation(String location) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'location',
      columns: ['idLocation'],
      where: 'location=?',
      whereArgs: [location],
    );
    return result.first['idLocation'];
  }

  Future<void> addProduct(Product product) async {
    final db = await database;
    int idType = await getIdTypeFromNameType(product.type);
    int idLocation = await getIdLocationFromNameLocation(product.location);
    await db.insert('product', {
      'product': product.name,
      'quantity': product.quantity,
      'idType': idType,
      'idLocation': idLocation,
    });
    getAllProducts();
    notifyListeners();
  }

  Future<void> deleteProduct(int idProduct) async {
    final db = await database;
    await db.delete('product', where: 'idProduct=?', whereArgs: [idProduct]);
    getAllProducts();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getProductsFromName(String name) async {
    final db = await database;
    return db.rawQuery(
      '''SELECT p.idProduct,p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation
      WHERE p.product LIKE ?''',
      ['%$name%'],
    );
  }

  Future<void> modifyNameProduct(int idProduct, String name) async {
    final db = await database;
    await db.update(
      'product',
      {'product': name},
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    getAllProducts();
    notifyListeners();
  }

  Future<void> modifyTypeProduct(int idProduct, String type) async {
    final db = await database;
    int idType = await getIdTypeFromNameType(type);
    await db.update(
      'product',
      {'idType': idType},
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    getAllProducts();
    notifyListeners();
  }

  Future<void> modifyLocationProduct(int idProduct, String location) async {
    final db = await database;
    int idLocation = await getIdLocationFromNameLocation(location);
    await db.update(
      'product',
      {'idLocation': idLocation},
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    getAllProducts();
    notifyListeners();
  }

  Future<void> modifyQuantiyProduct(int idProduct, int quantity) async {
    final db = await database;
    await db.update(
      'product',
      {'quantity': quantity},
      where: 'idProduct=?',
      whereArgs: [quantity],
    );
    getAllProducts();
    notifyListeners();
  }

  Future<void> modifyProduct(Product product, int idProduct) async {
    final db = await database;
    int idType = await getIdTypeFromNameType(product.type);
    int idLocation = await getIdLocationFromNameLocation(product.location);
    await db.update(
      'product',
      {
        'product': product.name,
        'quantity': product.quantity,
        'idType': idType,
        'idLocation': idLocation,
      },
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    getAllProducts();
    notifyListeners();
  }

  Future<bool> checkFirstLogin(String username, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['firstSignin'],
      where: 'username=? AND password=?',
      whereArgs: [username, password],
    );

    if (result.first['firstSignin'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> checkLogin(
    String username,
    String password,
  ) async {
    final db = await database;
    List<Map<String, dynamic>> user = await db.rawQuery(
      '''SELECT u.idUser,u.username,u.name,r.role as role,u.firstSignin FROM user u
                                                            INNER JOIN role r ON r.idRole=u.idRole
                                                            WHERE u.username=? AND u.password=?''',
      [username, password],
    );

    return user;
  }

  void updateSession(
    int idUser,
    String name,
    String username,
    String role,
    int firstLogin,
  ) {
    _userDatabase = UserDatabase(
      idUser: idUser,
      name: name,
      username: username,
      role: role,
      firstLogin: firstLogin,
    );
    notifyListeners();
  }

  void logout() {
    _userDatabase = null;
    notifyListeners();
  }

  Future<int> getTypeRegister(String type) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'registerType',
      columns: ['idType'],
      where: 'type=?',
      whereArgs: [type],
    );

    return result.first['idType'];
  }

  Future<void> newRegister(
    int idProduct,
    int idUser,
    String registerType,
    String date,
    int quantity,
  ) async {
    int newQuantity;
    final db = await database;
    int idRegisterType = await getTypeRegister(registerType);
    await db.insert('register', {
      'idProduct': idProduct,
      'idUser': idUser,
      'idRegistertype': idRegisterType,
      'date': date,
      'quantity': quantity,
    });
    int currentQuantity = await getQuantityFromProduct(idProduct);
    if ((registerType.compareTo("Coger") == 0)) {
      newQuantity = currentQuantity - quantity;
    } else {
      newQuantity = currentQuantity + quantity;
    }

    updateQuantity(idProduct, newQuantity);
    getAllProducts();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getHistoryRegisterByIdUser(
    int idUser,
  ) async {
    final db = await database;
    return await db.rawQuery(
      '''SELECT p.product,t.type as typeProduct,rt.type as typeRegister,r.quantity as quantity ,r.date, l.location FROM register r
                                INNER JOIN product p ON p.idProduct=r.idProduct
                                INNER JOIN registerType rt ON rt.idType=r.idRegisterType
                                INNER JOIN location l ON p.idLocation=l.idLocation
                                INNER JOIN type t on p.idType=t.idType
                                WHERE r.idUser=?
                              ''',
      [idUser],
    );
  }

  Future<void> addLocation(String location) async {
    final db = await database;
    await db.insert('location', {'location': location});
    getLocations();
    notifyListeners();
  }

  Future<void> addTypeProduct(String type) async {
    final db = await database;
    await db.insert('type', {'type': type});
    getTypes();
    notifyListeners();
  }

  Future<int> getIdRoleFromNameRole(String role) async {
    final db = await database;
    List<Map<String, dynamic>> resul = await db.query(
      'role',
      columns: ['idRole'],
      where: 'role=?',
      whereArgs: [role],
    );
    return resul.first['idRole'];
  }

  Future<void> deleteUser(int idUser) async {
    final db = await database;
    await db.delete('user', where: 'idUser=?', whereArgs: [idUser]);
    notifyListeners();
  }

  Future<void> changePassword(int idUser, String password) async {
    final db = await database;
    await db.update(
      'user',
      {'password': password},
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    getAllUsers();
    notifyListeners();
  }

  Future<void> updateUsername(int idUser, String username) async {
    final db = await database;
    await db.update(
      'user',
      {'username': username},
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    getAllUsers();
    notifyListeners();
  }

  Future<void> updateName(int idUser, String name) async {
    final db = await database;
    await db.update(
      'user',
      {'name': name},
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    getAllUsers();
    notifyListeners();
  }

  Future<void> updateRol(int idUser, String role) async {
    final db = await database;
    int idRole = await getIdRoleFromNameRole(role);
    await db.update(
      'user',
      {'idRole': idRole},
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    getAllUsers();
    notifyListeners();
  }

  Future<String> getPasswordFromUser(int idUser) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['password'],
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    return result.first['password'];
  }

  Future<void> updateUser(UserDatabase user) async {
    final db = await database;
    int idRole = await getIdRoleFromNameRole(user.role);
    await db.update(
      'user',
      {'username': user.username, 'name': user.name, 'idRole': idRole},
      where: 'idUser=?',
      whereArgs: [user.idUser],
    );
  }

  Future<List<Product>> showAllProducts() async {
    return _products
        .map(
          (product) => Product(
            name: product['name'],
            type: product['type'],
            location: product['location'],
            quantity: product['quantity'],
          ),
        )
        .toList();
  }

  Future<int> getQuantityFromProduct(int idProduct) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'product',
      columns: ['quantity'],
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    return int.parse(result.first['quantity']);
  }

  Future<void> updateQuantity(int idProduct, int newQuantity) async {
    final db = await database;
    db.update(
      'product',
      {'quantity': newQuantity},
      where: 'idProduct=?',
      whereArgs: [idProduct],
    );
    notifyListeners();
  }

  void clearFilter() {
    _filteredProducts = null;
    notifyListeners();
  }

  Future<void> changePasswordNewUser(int idUser, String password) async {
    final db = await database;
    await db.update(
      'user',
      {'password': password, 'firstSignin': 0},
      where: 'idUser=?',
      whereArgs: [idUser],
    );
    notifyListeners();
  }
}
