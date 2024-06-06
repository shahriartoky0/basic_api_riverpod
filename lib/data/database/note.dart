import 'package:isar/isar.dart';
part 'note.g.dart';

// run flutter pub run build_runner build command

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
