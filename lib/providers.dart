import 'package:sticky_notes/data/note_manager.dart';

NoteManager? _noteManager;

NoteManager noteManager() {
  _noteManager ??= NoteManager();
  return _noteManager!;
}
