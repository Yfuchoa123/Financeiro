// lib/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // ... (código existente do Singleton) ...
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'meu_financeiro.db');
    return await openDatabase(
      path,
      // IMPORTANTE: Incremente a versão do banco de dados
      version: 2,
      onCreate: _onCreate,
      // onUpgrade é chamado quando a versão do DB aumenta
      onUpgrade: _onUpgrade,
    );
  }

  // Cria as tabelas na primeira execução
  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  // Executa migrações quando a versão do DB muda
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Adiciona a nova tabela se estiver vindo da versão 1
      await db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT NOT NULL,
          type TEXT NOT NULL,
          value REAL NOT NULL,
          date TEXT NOT NULL,
          accountId INTEGER,
          categoryName TEXT,
          isPaid INTEGER NOT NULL
        )
      ''');
    }
  }

  // Método centralizado para criar todas as tabelas
  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE categories(
        name TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        isActive INTEGER NOT NULL,
        parentName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tags(
        name TEXT PRIMARY KEY,
        color INTEGER NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE accounts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        initialBalance REAL NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        type TEXT NOT NULL,
        value REAL NOT NULL,
        date TEXT NOT NULL,
        accountId INTEGER,
        categoryName TEXT,
        isPaid INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS bills(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL,
        type TEXT,
        value REAL,
        dueDate TEXT,
        isPaid INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }
}
