import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._constructor();
  static Database? _database;
  static const int _databaseVersion = 1;

//create variables for table names
  final String _loginTableName = 'login';
  final String _petTableName = 'pet';
  final String _logTableName = 'log';

  final String _name = 'name';
  final String _usernameColumn = 'username';
  final String _passwordColumn = 'password';
  final String _firstNameColumn = 'firstName';
  final String _petNameColumn = 'name';
  final String _petAgeColumn = 'age';
  final String _petSpeciesColumn = 'species';
  final String _petScheduleColumn = 'schedule';
  final String _logDateColumn = 'logDate';
  final String _logTypeColumn = 'logType';
  final String _logDescriptionColumn = 'logDescription';

  DatabaseServices._constructor();

  //create function that returns future database
  Future<Database> get database async {
    //check if database is already initialized
    if (_database != null) return _database!;
    //initialize database if not initialized
    _database = await getDatabase();
    // Ensure tables are created
    await _createTablesIfNotExist(_database!);
    return _database!;
  }

  Future<void> _createTablesIfNotExist(Database db) async {
    // Check if tables exist
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
        if (oldVersion < newVersion) {
          // Handle future schema changes here
          // Example:
          // if (oldVersion < 2) {
          //   db.execute('ALTER TABLE $_petTableName ADD COLUMN new_column TEXT');
          // }
        }
      },
    );
    return database;
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
      $_petScheduleColumn INTEGER NOT NULL,
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
    final id = await db.insert(_loginTableName, {
      _usernameColumn: username,
      _passwordColumn: password,
      _firstNameColumn: firstName,
    });
    return id;
  }

  Future<int> addPet(String name, int schedule, int userId) async {
    final db = await database;
    final petid = await db.insert(_petTableName, {
      _petNameColumn: name,
      _petSpeciesColumn: 'bunny',
      _petScheduleColumn: schedule,
      'userId': userId,
    });
    return petid;
  }


  
//leyyenah's code
  void addLog(int petId, String logType, String logDescription) async {
    final db = await database;
    await db.insert(_logTableName, {
      _logDateColumn: DateTime.now().toIso8601String(), // Current date and time
      _logTypeColumn: logType,
      _logDescriptionColumn: logDescription,
      'petId': petId, // Reference the petId
    });
  }

  Future<String?> getFirstName(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _loginTableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (maps.isEmpty) return null;
    return maps.first[_firstNameColumn] as String;
  }

    Future<int?> getPetId(int id) async {
    final db = await database;
    final List<Map<String, Object?>> maps = await db.query(
      _petTableName,
      where: 'userId = ?',
      whereArgs: [id],
    );
    if(maps.isEmpty) return null;
    final petId = maps.first['id'];
    return petId != null ? petId as int : null;
  }


//verify login
  Future<int?> verifyLogin(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      _loginTableName,
      where: '$_usernameColumn = ? AND $_passwordColumn = ?',
      whereArgs: [username, password],
    );
    
    if (results.isNotEmpty) {
      return results.first['id'] as int;
    }
    return null;
  }

}