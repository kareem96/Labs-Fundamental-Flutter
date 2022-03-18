


import 'package:flutter/material.dart';
import 'package:my_sqllite/db/db_provider.dart';
import 'package:my_sqllite/note_add_update_page.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Note'),),
      body: Consumer<DbProvider>(
        builder: (context, provider, child){
          final notes = provider.notes;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index){
              final note = notes[index];
              return Dismissible(
                  key: Key(note.id.toString()),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.delete,),
                    ),
                  ),
                  onDismissed: (direction){
                    provider.deleteNote(note.id!);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.description),
                      onTap: () async{
                        final selectedNote = await provider.getNoteById(note.id!);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return NoteAddUpdatePage(selectedNote);
                            }
                        ));
                      },
                    ),
                  )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => NoteAddUpdatePage()
          ));
        },
      ),
    );
  }
}
