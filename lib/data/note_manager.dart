import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sticky_notes/data/note.dart';

class NoteManager {

  static const _databaseName = 'notes.db';

  static const _databaseVersion = 1;

  Database? _database;

  Future<void> addNote(Note note) async {
    final db = await _getDatabase();
    await db.insert(Note.tableName, note.toRow());
  }

  Future<void> deleteNote(int id) async {
    final db = await _getDatabase();
    await db.delete(
      Note.tableName,
      where: '${Note.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<Note> getNote(int id) async {
    final db = await _getDatabase();
    final rows = await db.query(
      Note.tableName,
      where: '${Note.columnId} = ?',
      whereArgs: [id],
    );
    return Note.fromRow(rows.single);
  }

  Future<List<Note>> listNotes() async {
    final db = await _getDatabase();
    final rows = await db.query(Note.tableName,);
    return rows.map((row) => Note.fromRow(row)).toList();
  }

  Future<void> updateNote(int id, Note note) async {
    final db = await _getDatabase();
    await db.update(
      Note.tableName,
      note.toRow(),
      where: '${Note.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<Database> _getDatabase() async {
    if(_database == null) {
      _database = await openDatabase(
        _databaseName,
        version: _databaseVersion,
        onCreate: (db, version) {
          final sql = '''
      CREATE TABLE ${Note.tableName} (
        ${Note.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Note.columnTitle} TEXT,
        ${Note.columnBody} TEXT NOT NULL,
        ${Note.columnColor} INTEGER NOT NULL
      )
    ''';

        return db.execute(sql);
      },);
    }
    return _database!;
  }

}