import 'package:basic_api_riverpod/data/database/note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabaseNotifier extends StateNotifier<List<Note>> {
  static late Isar isar;
  bool loader = false;

  // here the super ([]) defines an empty List of Notes.
  // In the Fetch Data the state (which indicates the List of Notes ) gets the list of Notes.
  NoteDatabaseNotifier() : super([]) {
    initializeDatabase();
  }

  // Initializing the database
  Future<void> initializeDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
    loader = true;
    await fetchNotes();
    loader = false;
  }

  // Creating an object
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;
    loader = true;
    // Save to the database
    await isar.writeTxn(() => isar.notes.put(newNote));
    // Re-read the database
    await fetchNotes();
    loader = false;
  }

  Future<void> fetchNotes() async {
    final fetchedNotes = await isar.notes.where().findAll();
    state = fetchedNotes;
  }

  // Update a Note
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      loader = true;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // Refresh the database again
      await fetchNotes();
      loader = false;
    }
  }

  // Delete a Note
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    // Refresh the database again
    await fetchNotes();
  }
}

final noteProvider = StateNotifierProvider<NoteDatabaseNotifier, List<Note>>(
    (ref) => NoteDatabaseNotifier());
