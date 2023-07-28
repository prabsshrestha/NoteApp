import 'package:hive/hive.dart';
import 'package:noteapp/models/note.dart';

class HiveDatabase {
  //hive box
  final _myBox = Hive.box('note_database');
  //load note
  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    //if existing note return it otherwise return empty
    if (_myBox.get("All_Notes") != null) {
      List<dynamic> savedNotes = _myBox.get("All_Notes");
      for (int i = 0; i < savedNotes.length; i++) {
        //individual notes
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);

        //add list
        savedNotesFormatted.add(individualNote);
      }
    } else {
      //return default note
      savedNotesFormatted.add(Note(id: 0, text: 'First Note'));
    }
    return savedNotesFormatted;
  }

  //save note

  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    //note has id and text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    //store in hive
    _myBox.put("All_Notes", allNotesFormatted);
  }
}
