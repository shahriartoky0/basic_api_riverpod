import 'package:basic_api_riverpod/data/database/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static late Isar isar;

  NoteDatabase() {
    initializeDatabase();
  }
// Initializing the database
  Future<void> initializeDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  //taking an empty list of Note object to store the data
  final List<Note> currentNotes = [];

  // Creating an object
  Future<void> addNote(String textFromUser) async {
    final newNote = Note();
    newNote.text = textFromUser;
    // save to the database
    await isar.writeTxn(() => isar.notes.put(newNote));
    // re- read the database
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
  }

  // Update a Note
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      isar.writeTxn(() => isar.notes.put(existingNote));
      // refresh the Database again
      await fetchNotes();
    }
  }

  // Delete a Note
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
  }
}

final noteProvider = Provider<NoteDatabase>((ref) => NoteDatabase());
final noteDataProvider = FutureProvider((ref) async {
  return ref.watch(noteProvider).currentNotes;
});


