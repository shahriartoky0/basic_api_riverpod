import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/note.dart';
import '../../data/database/note_database.dart';

class update_dialouge extends StatelessWidget {
  const update_dialouge({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController noteTEController,
    required this.ref,
    required this.mounted, required this.note,

  }) : _formKey = formKey, _noteTEController = noteTEController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _noteTEController;
  final WidgetRef ref;
  final bool mounted;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Note'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          maxLines: 2,
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return "Cannot save empty notes";
            }
            return null;
          },
          controller: _noteTEController,
          decoration: InputDecoration(hintText: "Update your note"),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('Update Note'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ref
                  .read(noteProvider.notifier)
                  .updateNote(note.id, _noteTEController.text);
              _noteTEController.clear();
              if (mounted) {
                Navigator.pop(context);
              }
            }
          },
        ),
      ],
    );
  }
}