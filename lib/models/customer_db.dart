import 'dart:async';
import 'package:hisaab/models/customer_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDatabase {
  static final CustomerDatabase instance = CustomerDatabase._init();
  static Database? _database;

  CustomerDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('customers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER';

    await db.execute('''
    CREATE TABLE $tableCustomer(
    ${CustomerDBFields.id} $idType,
    ${CustomerDBFields.customer} $textType,
    ${CustomerDBFields.contact} $textType,
    ${CustomerDBFields.address} $textType,
    ${CustomerDBFields.lent} $integerType,
    ${CustomerDBFields.borrowed} $integerType,
    ${CustomerDBFields.time} $textType,
    )
    ''');
  }

  Future<Customer> create(Customer customer) async {
    final db = await instance.database;

    final json = customer.toJson();
    final columns =
        '${CustomerDBFields.customer}, ${CustomerDBFields.contact}, ${CustomerDBFields.address}, ${CustomerDBFields.time}, ${CustomerDBFields.lent}, ${CustomerDBFields.borrowed}';
    final values =
        '${json[CustomerDBFields.customer]},${json[CustomerDBFields.contact]}, ${json[CustomerDBFields.address]}, ${json[CustomerDBFields.time]}, ${json[CustomerDBFields.lent]}, ${json[CustomerDBFields.borrowed]}';

    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    // final id = await db.insert(tableCustomer, customer.toJson());
    return customer.copy(id: id);
  }

  Future<Customer> readCustomer(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCustomer,
      columns: CustomerDBFields.values,
      where: '${CustomerDBFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Customer>> readAllNodes() async {
    final db = await instance.database;
    final orderby = '${CustomerDBFields.time} ASC';
    final result = await db.query(tableCustomer);
    return result.map((json) => Customer.fromJson(json)).toList();
  }

  Future<int> update(Customer customer) async {
    final db = await instance.database;
    return db.update(
      tableCustomer,
      customer.toJson(),
      where: '${CustomerDBFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCustomer,
      where: '${CustomerDBFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future closed() async {
    final db = await instance.database;
    db.close();
  }
}
