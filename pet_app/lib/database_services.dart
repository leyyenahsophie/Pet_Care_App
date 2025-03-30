import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._constructor();
  static Database? _database;
  static const int _databaseVersion = 2; // Bump version to trigger upgrade

  final String _loginTableName = 'login';
  final String _petTableName = 'pet';
  final String _logTableName = 'log';

  final String _usernameColumn = 'username';
  final String _passwordColumn = 'password';
  final String _firstNameColumn = 'firstName';
  final String _petNameColumn = 'name';
  final String _petSpeciesColumn = 'species';
  final String _petWaterScheduleColumn = 'waterSchedule';
  final String _petFoodScheduleColumn = 'foodSchedule';
  final String _logDateColumn = 'logDate';
  final String _logTypeColumn = 'logType';
  final String _logDescriptionColumn = 'logDescription';

  DatabaseServices._constructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await getDatabase();
    await _createTablesIfNotExist(_database!);
    return _database!;
  }

  Future<void> _createTablesIfNotExist(Database db) async {
    final tables = await db.query('sqlite_master', where: 'type = ?', whereArgs: ['table']);
    final tableNames = tables.map((table) => table['name'] as String).toList();

    if (!tableNames.contains(_loginTableName)) {
      await _createTables(db);
    }
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final path = join(databaseDirPath, 'petapp_database.db');

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // remove this near the end
          await _addColumnIfNotExists(db, _petTableName, _petWaterScheduleColumn, 'INTEGER', defaultValue: '0');
          await _addColumnIfNotExists(db, _petTableName, _petFoodScheduleColumn, 'INTEGER', defaultValue: '0');
        }
      },
    );

    return database;
  }

//remove at the end
  Future<void> _addColumnIfNotExists(Database db, String table, String column, String type, {String? defaultValue}) async {
    final result = await db.rawQuery("PRAGMA table_info($table)");
    final columnExists = result.any((row) => row['name'] == column);

    if (!columnExists) {
      final defaultClause = defaultValue != null ? 'DEFAULT $defaultValue' : '';
      await db.execute('ALTER TABLE $table ADD COLUMN $column $type $defaultClause');
    }
  }

  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_loginTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_firstNameColumn TEXT NOT NULL,
        $_usernameColumn TEXT NOT NULL,
        $_passwordColumn TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_petTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_petNameColumn TEXT NOT NULL,
        $_petSpeciesColumn TEXT NOT NULL,
        $_petWaterScheduleColumn INTEGER NOT NULL,
        $_petFoodScheduleColumn INTEGER NOT NULL,
        userId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES $_loginTableName(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_logTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        petId INTEGER NOT NULL,
        $_logDateColumn TEXT NOT NULL,  
        $_logTypeColumn TEXT NOT NULL,
        $_logDescriptionColumn TEXT NOT NULL,
        FOREIGN KEY (petId) REFERENCES $_petTableName(id)
      )
    ''');
  }

  Future<int> addLogin(String username, String password, String firstName) async {
    final db = await database;
    return await db.insert(_loginTableName, {
      _usernameColumn: username,
      _passwordColumn: password,
      _firstNameColumn: firstName,
    });
  }

  Future<int> addPet(String name, int schedule, int schedule2, int userId) async {
    final db = await database;
    return await db.insert(_petTableName, {
      _petNameColumn: name,
      _petSpeciesColumn: 'bunny',
      _petWaterScheduleColumn: schedule,
      _petFoodScheduleColumn: schedule2,
      'userId': userId,
    });
  }

  void addLog(int petId, String logType, String logDescription) async {
    final db = await database;
    await db.insert(_logTableName, {
      _logDateColumn: DateTime.now().toIso8601String(),
      _logTypeColumn: logType,
      _logDescriptionColumn: logDescription,
      'petId': petId,
    });
  }

  Future<String?> getFirstName(int? userId) async {
    final db = await database;
    final maps = await db.query(_loginTableName, where: 'id = ?', whereArgs: [userId]);
    return maps.isNotEmpty ? maps.first[_firstNameColumn] as String : null;
  }

  Future<String?> getUserName(int? userId) async {
    final db = await database;
    final maps = await db.query(_loginTableName, where: 'id = ?', whereArgs: [userId]);
    return maps.isNotEmpty ? maps.first[_usernameColumn] as String : null;
  }

  Future<String?> getPetName(int? userId, int? petId) async {
    final db = await database;
    final maps = await db.query(_petTableName, where: 'id = ?', whereArgs: [petId]);
    return maps.isNotEmpty ? maps.first[_petNameColumn] as String : null;
  }

  Future<int?> getPetId(int? id) async {
    final db = await database;
    final maps = await db.query(_petTableName, where: 'userId = ?', whereArgs: [id]);
    return maps.isNotEmpty ? maps.first['id'] as int : null;
  }

  Future<void> updateReminders(int? petId, int? newWater, int? newFood) async {
    final db = await database;

    await db.update(
      _petTableName,
      {_petWaterScheduleColumn: newWater},
      where: 'id = ?',
      whereArgs: [petId],
    );

    await db.update(
      _petTableName,
      {_petFoodScheduleColumn: newFood},
      where: 'id = ?',
      whereArgs: [petId],
    );
  }

  Future<int?> verifyLogin(String username, String password) async {
    final db = await database;
    final results = await db.query(
      _loginTableName,
      where: '$_usernameColumn = ? AND $_passwordColumn = ?',
      whereArgs: [username, password],
    );
    return results.isNotEmpty ? results.first['id'] as int : null;
  }
}
