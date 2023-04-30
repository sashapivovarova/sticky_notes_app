import 'package:flutter/material.dart';
import 'package:sticky_notes/data/note.dart';
import 'package:sticky_notes/page/note_edit_page.dart';
import 'package:sticky_notes/page/note_view_page.dart';
import '../providers.dart';

class NoteListPage extends StatefulWidget {

  static const routeName ='/';


  @override
  State createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soru Notes'),
      ),
      body: FutureBuilder<List<Note>>(
        future: noteManager().listNotes(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snap.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text('Unexpected Error'),
              ),
            );
          }

          final notes = snap.requireData;
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            itemCount: notes.length,
            itemBuilder: (context, index) => _buildCard(notes[index]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'New Note',
        onPressed: () {
          Navigator.pushNamed(context, NoteEditPage.routeName).then((_) {
            setState(() {});
          });
          },
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
                  note.title.isEmpty ? '(null)' :note.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:16.0),
                Expanded(
                    child: Text(
                      note.body,
                      overflow: TextOverflow.fade,
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