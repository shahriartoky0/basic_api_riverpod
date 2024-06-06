import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/note_database.dart';

class NoteTakingPage extends ConsumerStatefulWidget {
  @override
  _NoteTakingPageState createState() => _NoteTakingPageState();
}

class _NoteTakingPageState extends ConsumerState<NoteTakingPage> {
  final TextEditingController _noteTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch the notes when the page initializes
    ref.read(noteProvider).fetchNotes();
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Can not save Empty Notes";
                    }
                    return null;
                  },
                  controller: _noteTEController,
                  decoration: InputDecoration(hintText: "Enter your note"),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  child: Text('Save Note'),
                  onPressed: ()  {
                    if (_formKey.currentState!.validate()) {
                      ref.read(noteProvider).addNote(_noteTEController.text);
                      _noteTEController.clear();
                      ref.read(noteProvider).fetchNotes();
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = ref.watch(noteProvider);
    print(noteDatabase);

    return Scaffold(
      appBar: AppBar(
        title: Text("Note Taking"),
      ),
      body: FutureBuilder(
        future: noteDatabase.fetchNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (noteDatabase.currentNotes.isEmpty) {
            return Center(child: Text("No notes yet"));
          } else {
            return ListView.builder(
              itemCount: noteDatabase.currentNotes.length,
              itemBuilder: (context, index) {
                final note = noteDatabase.currentNotes[index];
                return ListTile(
                  title: Text(note.text),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      noteDatabase.deleteNote(note.id!);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
