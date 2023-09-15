import 'package:flutter/material.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/providers.dart';

import '../data/note.dart';

class NoteViewPage extends StatefulWidget {
  static const routeName = '/view';

  final int id;

  const NoteViewPage(this.id, {super.key});

  @override
  State createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Note>(
      future: noteManager().getNote(widget.id),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snap.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Unexpected Error'),
            ),
          );
        }

        final note = snap.requireData;
        return Scaffold(
          appBar: AppBar(
            title: Text(note.title.isEmpty ? 'null' : note.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit',
                onPressed: () {
                  _edit(widget.id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Delete',
                onPressed: () {
                  _confirmDelete(widget.id);
                },
              ),
            ],
          ),
          body: SizedBox.expand(
            child: Container(
              color: note.color,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                child: Text(note.body),
              ),
            ),
          ),
        );
      },
    );
  }

  void _edit(int index) {
    Navigator.pushNamed(context, NoteEditPage.routeName, arguments: index)
        .then((_) {
      setState(() {});
    });
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete the note'),
          content: const Text('Are you sure to delete the note?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                noteManager().deleteNote(index);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
