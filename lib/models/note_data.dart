import 'package:flutter/material.dart';
import 'package:noteapp/data/hive_database.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDatabase();

  // list of notes
  List<Note> allNotes = [
    //default first note
  ];

  void initalizeNotes() {
    allNotes = db.loadNotes();
  }

  //get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  //add a new notes
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // update a note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNode(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
