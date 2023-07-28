import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/models/note_data.dart';
import 'package:noteapp/pages/editing_note_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initalizeNotes();
  }

  //create a new note
  void createNote() {
    //create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //create blank note
    Note newNote = Note(
      id: id,
      text: '',
    );
    //got to edit note
    goToNotePage(newNote, true);
  }

  // got to note editing  page
  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditingNotePage(
                  isNewNote: isNewNote,
                  note: note,
                )));
  }

  // delete node
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNode(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color.fromARGB(255, 196, 196, 197),
            onPressed: createNote,
            elevation: 0.0,
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text('Add Notes'),
          ),
          body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 25.0, top: 45, bottom: 5),
                child: Text('Notes',
                    style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7))),
              ),

              //list of notes
              value.getAllNotes().length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text(
                        'Nothing here',
                        style: TextStyle(color: Colors.grey[400]),
                      )),
                    )
                  : CupertinoListSection.insetGrouped(
                      children: List.generate(
                      value.getAllNotes().length,
                      (index) => CupertinoListTile(
                        title: Text(value.getAllNotes()[index].text),
                        onTap: () =>
                            goToNotePage(value.getAllNotes()[index], false),
                        trailing: IconButton(
                            onPressed: () =>
                                deleteNote(value.getAllNotes()[index]),
                            icon: Icon(Icons.delete_outline_rounded)),
                      ),
                    ))
            ]),
          )),
    );
  }
}
