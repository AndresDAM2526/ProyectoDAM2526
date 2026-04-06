import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:proyecto_dam_2526/model/DatabaseProduct.dart';
import 'package:proyecto_dam_2526/model/product.dart';
import 'package:proyecto_dam_2526/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService extends ChangeNotifier {
  late final Future<Database> database;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _types = [];
  List<Map<String, dynamic>> get types => _types;

  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> get locations => _locations;

  List<Map<String, dynamic>> _historyRegister = [];
  List<Map<String, dynamic>> get historyRegister => _historyRegister;
  User? _user;
  User? get user => _user;

  DatabaseService() {
    database = _loadDatabase();
    getAllProducts();
    getTypes();
    getLocations();
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
          await db.execute('''CREATE TABLE IF NOT EXISTS rol(
                            idRol INTEGER PRIMARY KEY AUTOINCREMENT,
                            rol TEXT NOT NULL
                          )''');

          await db.execute('''CREATE TABLE IF NOT EXISTS user(
                            idUser INTEGER PRIMARY KEY AUTOINCREMENT,
                            user TEXT NOT NULL,
                            password TEXT NOT NULL,
                            name TEXT NOT NULL,
                            idRol INTEGER NOT NULL,

                            FOREIGN KEY (idRol) REFERENCES rol(idRol) ON DELETE CASCADE ON UPDATE CASCADE
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
          await db.insert('rol', {'rol': 'Admin'});
          await db.insert('rol', {'rol': 'Profesor'});
          await db.insert('rol', {'rol': 'Alumno'});

          await db.insert('user', {
            'user': 'andres',
            'password': 'andres',
            'name': 'Andres Correa Garcia',
            'idRol': '1',
          });

          await db.insert('user', {
            'user': 'juan',
            'password': 'juan',
            'name': 'Juan Perez Dominguez',
            'idRol': '3',
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

  Future<void> getAllProducts() async {
    final db = await database;
    _products = await db.rawQuery(
      '''SELECT p.product,p.quantity,t.type as type,l.location  as location FROM product p 
      INNER JOIN type t ON p.idType=t.idType 
      INNER JOIN location l ON l.idLocation=p.idLocation''',
    );
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

  Future<bool> checkLogin(String user, String password) async {
    final db = await database;
    List<Map<String, dynamic>> users = await db.rawQuery(
      '''SELECT u.idUser,u.user,u.name,r.rol as rol FROM user u
                                                            INNER JOIN rol r ON r.idRol=u.idRol
                                                            WHERE u.user=? AND u.password=?''',
      [user, password],
    );
    if (users.length == 1) {
      _user = User(
        idUser: users.first['idUser'],
        name: users.first['name'],
        user: users.first['user'],
        rol: users.first['rol'],
      );
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    _user = null;
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
    final db = await database;
    int idRegisterType = await getTypeRegister(registerType);
    await db.insert('register', {
      'idProduct': idProduct,
      'idUser': idUser,
      'idRegistertype': idRegisterType,
      'date': date,
      'quantity': quantity,
    });
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
                              ''',
    );
  }

  Future<void> addLocation(String location) async {
    final db = await database;
    await db.insert('location', {'location': location});
  }
}
