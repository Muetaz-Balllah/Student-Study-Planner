import 'package:homework/course.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._createInstance();
  static final DatabaseHelper _helper = DatabaseHelper._createInstance();
  factory DatabaseHelper() => _helper;

  static Database? _db;
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), "courses.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE courses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            units INTEGER,
            teacher TEXT,
            image TEXT,
            students INTEGER,
            semester INTEGER,
            hours FLOAT
          )
        ''');
      },
    );
  }

  Future<int> insert(Course c) async {
    final dbClinet = await db;
    return await dbClinet.insert("courses", c.toMap());
  }

  Future<List<Course>> getsCourse() async {
    final dbClinet = await db;
    final List<Map<String, dynamic>> maps = await dbClinet.query("courses");
    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
  }

  Future<int> upDate(Course c) async {
    final dbClinet = await db;
    return await dbClinet.update(
      "courses",
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }

  Future<void> delete(int id) async {
    final dbClinet = await db;
    await dbClinet.delete("courses", where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final dbClinet = await db;
    dbClinet.close();
  }
}
