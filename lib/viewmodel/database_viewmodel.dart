import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseViewmodel extends ChangeNotifier {
  late final Future<Database> database;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _types = [];
  List<Map<String, dynamic>> get types => _types;

  List<Map<String, dynamic>> _locations = [];
  List<Map<String, dynamic>> get locations => _locations;

  DatabaseViewmodel() {
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

          await db.insert('type', {'type': 'Memoria'});
          await db.insert('type', {'type': 'Cable'});
          await db.insert('type', {'type': 'Ordenador'});
          await db.insert('type', {'type': 'Períferico'});

          await db.insert('location', {'location': 'Almacen-01'});
          await db.insert('location', {'location': 'Almacen-02'});
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

  Future<List<String>> showLocations() async{
    return locations
        .map((location) => location['location'].toString())
        .toList();
  }
}
