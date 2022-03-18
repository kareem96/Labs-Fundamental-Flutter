import 'package:flutter/material.dart';
import 'package:my_sqllite/db/db_provider.dart';
import 'package:my_sqllite/model/note.dart';
import 'package:provider/provider.dart';

class NoteAddUpdatePage extends StatefulWidget {
  final Note? note;

  NoteAddUpdatePage([this.note]);

  @override
  _NoteAddUpdatePageState createState() => _NoteAddUpdatePageState();
}

class _NoteAddUpdatePageState extends State<NoteAddUpdatePage> {

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note'),),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Title'
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description'
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Simpan'),
                onPressed: () async {
                  if (!isUpdate) {
                    final note = Note(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<DbProvider>(context, listen: false).addNote(
                        note);
                  } else {
                    final note = Note(
                        id: widget.note!.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                    );
                    Provider.of<DbProvider>(context, listen: false).updateNote(note);
                  }
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
