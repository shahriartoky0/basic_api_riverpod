import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/note.dart';
import '../../data/database/note_database.dart';
import '../widgets/bottom_modal.dart';
import '../widgets/update_dialouge.dart';

class NoteTakingPage extends ConsumerStatefulWidget {
  const NoteTakingPage({super.key});

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
    ref.read(noteProvider.notifier).fetchNotes();
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return bottom_modal(
            formKey: _formKey, noteTEController: _noteTEController, ref: ref);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Taking"),
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes yet"))
          : Visibility(
              replacement: const Center(child: CircularProgressIndicator()),
              visible: ref.read(noteProvider.notifier).loader == false,
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    onLongPress: () => _showUpdateDialogue(note),
                    title: Text(note.text),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ref.read(noteProvider.notifier).deleteNote(note.id);
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showUpdateDialogue(Note note) {
    _noteTEController.text =
        note.text; // Set the current note text to the controller
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return update_dialouge(
            formKey: _formKey,
            noteTEController: _noteTEController,
            ref: ref,
            mounted: mounted,
            note: note);
      },
    );
  }
}
