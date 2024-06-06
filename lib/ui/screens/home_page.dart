import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteTakingPage extends StatefulWidget {
  @override
  _NoteTakingPageState createState() => _NoteTakingPageState();
}

class _NoteTakingPageState extends State<NoteTakingPage> {
  final TextEditingController _noteTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _noteText = "";

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
                  onPressed: () {
                    // Handle saving the note (e.g., store in database)
                    if (_formKey.currentState!.validate()) {

                    }
                    Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Taking"),
      ),
      body: Center(
        child: Text("No notes yet"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
