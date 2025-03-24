import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._constructor();
  static Database? _database;

//create variables for table names
  final String _loginTableName = 'login';
  final String _petTableName = 'pet';
  final String _logTableName = 'log';

  final String _usernameColumn = 'username';
  final String _passwordColumn = 'password';
  final String _petNameColumn = 'name';
  final String _petAgeColumn = 'age';
  final String _petSpeciesColumn = 'species';
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
    return _database!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final path = join(databaseDirPath, 'petapp_database.db');
    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(''' 
        CREATE TABLE $_loginTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $_usernameColumn TEXT NOT NULL,
          $_passwordColumn TEXT NOT NULL
        )

        CREATE TABLE $_petTableName  (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          $_petNameColumn TEXT NOT NULL,
          $_petAgeColumn INTEGER NOT NULL,
          $_petSpeciesColumn TEXT NOT NULL,
          
        )

        CREATE TABLE $_logTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          petId INTEGER NOT NULL,
          $_logDateColumn TEXT NOT NULL,  
          $_logTypeColumn TEXT NOT NULL,
          $_logDescriptionColumn TEXT NOT NULL,
          FOREIGN KEY (petId) REFERENCES $_petTableName(id)
        )
        ''');
      });
    return database;
  }

}

