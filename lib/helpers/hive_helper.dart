import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class HiveHelper {

  static const String notesBoxName = 'notes';

  static Box<Note> get notesBox {
    return Hive.box<Note>(notesBoxName);
  }

  // Add Note
  static Future<void> addNote(Note note) async {
    await notesBox.add(note);
  }

  // Update Note
  static Future<void> updateNote(
    int index,
    Note note,
  ) async {
    await notesBox.put(index, note);
  }

  // Delete Note
  static Future<void> deleteNote(int index) async {
    await notesBox.deleteAt(index);
  }

  // Delete All Notes
  static Future<void> deleteAllNotes() async {
    await notesBox.clear();
  }

  // Pin / Unpin Note
  static Future<void> togglePin(int index) async {

    Note note = notesBox.getAt(index)!;

    note.isPinned = !note.isPinned;

    await note.save();
  }

  // Get All Notes
  static List<Note> getAllNotes() {
    return notesBox.values.toList();
  }

  // Get Pinned Notes
  static List<Note> getPinnedNotes() {

    return notesBox.values
        .where((note) => note.isPinned)
        .toList();
  }
}