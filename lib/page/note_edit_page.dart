import 'package:flutter/material.dart';
import 'package:sticky_notes/data/note.dart';
import 'package:sticky_notes/providers.dart';

class NoteEditPage extends StatefulWidget {
  static const routeName = '/edit';

  final int? id;

  NoteEditPage(this.id);

  @override
  State createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleController = TextEditingController();

  final bodyController = TextEditingController();

  Color color = Note.colorDefault;


  @override
  void initState() {
    super.initState();
    final noteId = widget.id;
    if (noteId != null) {
      noteManager().getNote(noteId).then((note) {
        titleController.text = note.title;
        bodyController.text = note.body;
        setState(() {
          color = note.color;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteEdit'),
        actions: [
          IconButton(
            onPressed: _displayColorSelectionDialog,
            icon: Icon(Icons.color_lens),
            tooltip: 'Select Background Color'
          ),
          IconButton(onPressed: _saveNote, icon: Icon(Icons.save), tooltip: 'Save',),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: color,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title'
                  ),
                  maxLines: 1,
                  style: TextStyle(fontSize: 20.0),
                  controller: titleController,
                ),
                SizedBox(height: 8.0,),
                TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the content',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: bodyController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayColorSelectionDialog() {
    FocusManager.instance.primaryFocus?.unfocus();

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Select Background Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('None'),
              onTap: () => _applyColor(Note.colorDefault),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorRed,),
              title: Text('Red'),
              onTap: () => _applyColor(Note.colorRed),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorOrange,),
              title: Text('Orange'),
              onTap: () => _applyColor(Note.colorOrange),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorYellow,),
              title: Text('Yellow'),
              onTap: () => _applyColor(Note.colorYellow),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorLime,),
              title: Text('Lime'),
              onTap: () => _applyColor(Note.colorLime),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Note.colorBlue,),
              title: Text('Blue'),
              onTap: () => _applyColor(Note.colorBlue),
            )
          ],
        ),
      );
    },);
  }

  void _applyColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      color = newColor;
    });
  }

  void _saveNote() {
    if (bodyController.text.isNotEmpty) {
      final note = Note(
        bodyController.text,
        title: titleController.text,
        color: color,
      );

      final noteIndex = widget.id;
      if (noteIndex != null) {
        noteManager().updateNote(noteIndex, note);
      } else {
        noteManager().addNote(note);
      }

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The content is empty'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}