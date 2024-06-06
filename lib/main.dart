import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'data/database/note_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final noteDatabase = NoteDatabase();
  await noteDatabase.initializeDatabase();
  runApp(const ProviderScope(child: MyApp()));
}
