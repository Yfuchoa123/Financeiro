import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Ativa o suporte a foreign keys
    await db.execute('PRAGMA foreign_keys = ON;');
    await _createTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Ativa o suporte a foreign keys
    await db.execute('PRAGMA foreign_keys = ON;');
    if (oldVersion < 2) {
      // Garante que todas as tabelas estejam criadas ou atualizadas
      await _createTables(db);
    }
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS categories(
        name TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        isActive INTEGER NOT NULL,
        parentName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS tags(
        name TEXT PRIMARY KEY,
        color INTEGER NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS accounts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        initialBalance REAL NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        type TEXT NOT NULL,
        value REAL NOT NULL,
        date TEXT NOT NULL,
        accountId INTEGER,
        categoryName TEXT,
        isPaid INTEGER NOT NULL,
        FOREIGN KEY (accountId) REFERENCES accounts(id) ON DELETE SET NULL,
        FOREIGN KEY (categoryName) REFERENCES categories(name) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS bills(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        value REAL NOT NULL,
        dueDate TEXT NOT NULL,
        isPaid INTEGER NOT NULL DEFAULT 0
        -- Sugestão: adicione FOREIGN KEYs se precisar de relacionamento
      )
    ''');
  }
}
