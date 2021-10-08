import 'package:hisaab/models/cash_log_data.dart';
import 'package:hisaab/models/customer_data.dart';
import 'package:hisaab/utils/sql_queries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;

/// Handles DB operations using the sqlite instance
class DatabaseService {
  static const dbName = 'hisaab.db';
  static const version = 1;

  static Future<Database> openDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    final dbInstance = await openDatabase(
      path,
      version: version,
      onConfigure: (db) async {
        print('onConfigure called');
        await db.execute("PRAGMA foreign_keys = ON");
      },
      onCreate: (db, version) async {
        print('onCreate called');
        await db.execute(createCustomersTable);
        await db.execute(createCashLogsTable);
      },
      onUpgrade: (db, oldVer, newVer) {
        print('onUpgrade called');
      },
      onDowngrade: (db, oldVer, newVer) {
        print('onDowngrade called');
      },
      onOpen: (db) {
        print('onOpen');
      },
    );

    return dbInstance;
  }

  static Future<int> insertCustomer({
    required Database database,
    required Customer customer,
  }) async {
    final id = await database.insert('CUSTOMERS', customer.toMap());
    return id;
  }

  static Future<List<Customer>> getAllCustomers({
    required Database database,
  }) async {
    final customersMap = await database.query('CUSTOMERS');

    final customers = customersMap
        .map(
          (map) => Customer.fromJson(map),
        )
        .toList();

    return customers;
  }

  static Future<void> deleteCustomer(int id, Database database) async {
    final db = database;
    await db.delete('CUSTOMERS',where: 'id = ?', whereArgs: [id]);
  }

  // static Future<void> updateCustomer(){
  //
  // }

  static Future<int> insertCashLog({
    required Database database,
    required CashLog cashLog,
  }) async {
    final id = await database.insert('CASHLOGS', cashLog.toMap());
    return id;
  }

  static Future<List<CashLog>> getAllCashLogs({
    required Database database,
  }) async {
    final cashLogsMap = await database.query('CASHLOGS');

    final cashLogs = cashLogsMap
        .map(
          (map) => CashLog.fromJson(map),
        )
        .toList();

    return cashLogs;
  }

  static Future<void> deleteCashLog(int id, Database database) async {
    final db = database;
    await db.delete('CASHLOGS',where: 'id = ?', whereArgs: [id]);
  }
}
