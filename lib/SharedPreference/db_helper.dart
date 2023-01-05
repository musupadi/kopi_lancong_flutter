import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Model/Cashier.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class db_helper{

  static final db_helper instance = db_helper._init();

  static Database? _database;

  db_helper._init();

  Future<Database> get database async{
    if(_database !=null) return _database!;

    _database = await _initDB('apos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes (
    ${CashierFields.id} $idType,
    ${CashierFields.id_product} $integerType,
    ${CashierFields.nama} $textType,
    ${CashierFields.jumlah} $integerType,
    ${CashierFields.harga} $integerType
    )
    ''');
  }

  Future<Cashier> create(Cashier cashiers) async{
    final db = await instance.database;
    // final json = cashiers.toJson();
    // final columns  = '${CashierFields.nama},${CashierFields.jumlah},${CashierFields.harga}';
    // final values = ''
    //     '${json[CashierFields.nama]},'
    //     '${json[CashierFields.jumlah]},'
    //     '${json[CashierFields.harga]}';
    //
    // final id = await db.rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, cashiers.toJson());
    return cashiers.copy(id: id);
  }

  Future<Cashier> read(int id) async{
      final db = await instance.database;

      final map = await db.query(
        tableNotes,
        columns: CashierFields.values,
        where: '${CashierFields.id} = ?',
        whereArgs: [id]
      );

      if (map.isEmpty){
        return Cashier.fromJson(map.first);
      }else {
        throw Exception('ID $id not found');
      }
  }

  Future<List<Cashier>> readAll() async{
    final db = await instance.database;


    final result = await db.query(tableNotes);

    return result.map((json) => Cashier.fromJson(json)).toList();
  }

  Future<int> update(Cashier cashier) async {
    final db = await instance.database;

    return db.update(tableNotes,
        cashier.toJson(),
        where: '${CashierFields.id_product} = ?',
        whereArgs: [cashier.id_product]
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${CashierFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future<int> deleteAll() async{
    final db = await instance.database;

    return await db.delete(
        tableNotes
    );
  }

  Future close() async{
      final db = await instance.database;

      db.close();
  }


}
