import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'compassion_app.db';
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
    String path = join(await getDatabasesPath(), _databaseName);
    try {
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      if (e is DatabaseException) {
        // Handle database corruption
        await deleteDatabase(path);
        return await openDatabase(
          path,
          version: 1,
          onCreate: _onCreate,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE journal_entries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        date TEXT,
        mood TEXT
      )
    ''');
  }

  // Journal Entry operations
Future<void> insertOrUpdateJournalEntry(JournalEntry entry) async {
    final db = await database;
    final existingEntry = await getJournalEntryForDate(entry.date);
    if (existingEntry != null) {
      await db.update(
        'journal_entries',
        entry.toMap(),
        where: 'id = ?',
        whereArgs: [existingEntry.id],
      );
    } else {
      await db.insert(
        'journal_entries',
        entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('journal_entries');
    return List.generate(maps.length, (i) {
      return JournalEntry.fromMap(maps[i]);
    });
  }

  Future<JournalEntry?> getJournalEntryForDate(DateTime date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'journal_entries',
      where: 'date = ?',
      whereArgs: [date.toIso8601String()],
    );
    if (maps.isNotEmpty) {
      return JournalEntry.fromMap(maps.first);
    } else {
      return null;
    }
  }

  List<JournalEntry> getRecentEntries(List<JournalEntry> entries) {
    final now = DateTime.now();
    final fiveDaysAgo = now.subtract(const Duration(days: 5));
    return entries.where((entry) => entry.date.isAfter(fiveDaysAgo) && entry.date.isBefore(now)).toList();
  }


  Future<void> deleteJournalEntry(int id) async {
    final db = await database;
    await db.delete('journal_entries', where: 'id = ?', whereArgs: [id]);
  }

}
