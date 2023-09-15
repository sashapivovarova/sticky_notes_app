import 'package:flutter/material.dart';
import 'package:sticky_notes/data/note.dart';
import 'package:sticky_notes/providers.dart';

class NoteEditPage extends StatefulWidget {
  static const routeName = '/edit';

  final int? id;

  const NoteEditPage(this.id, {super.key});

  @override
  State createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  Color color = Note.colorDefault;
  bool newMemo = true;

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
          newMemo = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          newMemo ? 'New Memo' : 'Edit',
        ),
        actions: [
          IconButton(
              onPressed: _displayColorSelectionDialog,
              icon: const Icon(
                Icons.color_lens_rounded,
              ),
              tooltip: 'Select Background Color'),
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(
              Icons.save_rounded,
            ),
            tooltip: 'Save',
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: color,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input the title',
                    labelText: 'Title',
                  ),
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20.0),
                  controller: titleController,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the content',
                    labelText: 'Memo',
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

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Memo Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorDefault,
                ),
                title: const Text('White'),
                onTap: () => _applyColor(Note.colorDefault),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorRed,
                ),
                title: const Text('Red'),
                onTap: () => _applyColor(Note.colorRed),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorOrange,
                ),
                title: const Text('Orange'),
                onTap: () => _applyColor(Note.colorOrange),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorYellow,
                ),
                title: const Text('Yellow'),
                onTap: () => _applyColor(Note.colorYellow),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorLime,
                ),
                title: const Text('Lime'),
                onTap: () => _applyColor(Note.colorLime),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Note.colorBlue,
                ),
                title: const Text('Blue'),
                onTap: () => _applyColor(Note.colorBlue),
              )
            ],
          ),
        );
      },
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Memo is empty'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
