import 'dart:async';
import 'package:hisaab/models/cash_log_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class CashLogDatabase {

  static final CashLogDatabase instance = CashLogDatabase._init();
  static Database? _database;

  CashLogDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('cashlogs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1);
  }

  Future _createDB(Database db, int version) async{

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final integerType = 'INTEGER';

    await db.execute('''
    CREATE TABLE $tableCashLog(
    ${CashLogDBFields.id} $idType,
    ${CashLogDBFields.cashIn} $integerType,
    ${CashLogDBFields.cashOut} $integerType,
    ${CashLogDBFields.description} $textType,
    ${CashLogDBFields.time} $textType,
    )
    ''');
  }

  Future<CashLog> create(CashLog cashLog) async{
    final db = await instance.database;

    final json = cashLog.toJson();
    final columns = '${CashLogDBFields.cashIn}, ${CashLogDBFields.cashOut}, ${CashLogDBFields.description}, ${CashLogDBFields.time}';
    final values = '${json[CashLogDBFields.cashIn]},${json[CashLogDBFields.cashOut]}, ${json[CashLogDBFields.description]}, ${json[CashLogDBFields.time]}}';

    final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    // final id = await db.insert(tableCustomer, customer.toJson());
    return cashLog.copy(id: id);
  }

  Future<CashLog> readCashLog(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCashLog,
      columns: CashLogDBFields.values,
      where: '${CashLogDBFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return CashLog.fromJson(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }
  }

  Future<List<CashLog>> readAllNodes() async{
    final db = await instance.database;
    final orderby = '${CashLogDBFields.time} ASC';
    final result = await db.query(tableCashLog);
    return result.map((json) => CashLog.fromJson(json)).toList();
  }

  Future<int> update(CashLog cashLog) async{
    final db = await instance.database;
    return db.update(
      tableCashLog,
      cashLog.toJson(),
      where: '${CashLogDBFields.id} = ?',
      whereArgs: [cashLog.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableCashLog,
      where: '${CashLogDBFields.id} = ?',
      whereArgs: [id],
    );
  }


  Future closed() async{
    final db = await instance.database;
    db.close();
  }
}


