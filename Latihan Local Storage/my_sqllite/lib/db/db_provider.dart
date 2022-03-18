



import 'package:flutter/cupertino.dart';
import 'package:my_sqllite/db/database_helper.dart';
import 'package:my_sqllite/model/note.dart';

class DbProvider extends ChangeNotifier{
  List<Note> _notes = [];
  late DatabaseHelper _databaseHelper;

  List<Note> get notes => _notes;

  DbProvider(){
    _databaseHelper = DatabaseHelper();
    _getAllNotes();
  }

  void _getAllNotes() async {
    _notes = await _databaseHelper.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async{
    await _databaseHelper.insertNote(note);
    _getAllNotes();
  }

  Future<Note> getNoteById(int id)async{
    return await _databaseHelper.getNoteById(id);
  }

  void updateNote(Note note) async{
    await _databaseHelper.updateNote(note);
    _getAllNotes();
  }

  void deleteNote(int id) async{
    await _databaseHelper.deleteNote(id);
    _getAllNotes();
  }


}