import 'package:flutter/material.dart';
import 'package:sticky_notes/data/note.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/page/note_view_page.dart';
import '../providers.dart';

class NoteListPage extends StatefulWidget {
  static const routeName = '/list';

  const NoteListPage({super.key});

  @override
  State createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sticky Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: noteManager().listNotes(),
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

          final notes = snap.requireData;
          return GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            itemCount: notes.length,
            itemBuilder: (context, index) => _buildCard(notes[index]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New Note',
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(Note note) {
    return InkWell(
      child: Card(
        color: note.color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isEmpty ? '(null)' : note.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  note.body,
                  style: const TextStyle(
                    fontSize: 14.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          NoteViewPage.routeName,
          arguments: note.id,
        ).then((_) {
          setState(() {});
        });
      },
    );
  }
}
