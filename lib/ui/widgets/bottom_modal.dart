import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/note_database.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController noteTEController,
    required this.ref,
  })  : _formKey = formKey,
        _noteTEController = noteTEController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _noteTEController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20, left: 20, right: 20,
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust padding to avoid keyboard overlap
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                maxLines: 4,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return "Can not save Empty Notes";
                  }
                  return null;
                },
                controller: _noteTEController,
                decoration: const InputDecoration(hintText: "Enter your note"),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                child: const Text('Save Note'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ref
                        .read(noteProvider.notifier)
                        .addNote(_noteTEController.text);
                    _noteTEController.clear();
                    Navigator.pop(context);
                  }
                },
              ),
              // const SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
