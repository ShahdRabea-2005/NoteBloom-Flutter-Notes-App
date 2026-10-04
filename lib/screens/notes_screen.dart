import 'package:flutter/material.dart';

import '../models/note.dart';
import '../helpers/hive_helper.dart';
import '../widgets/note_card.dart';

class NotesScreen extends StatefulWidget {

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      showWelcomeDialog();

    });
  }

  // =========================
  // Welcome Dialog
  // =========================

  void showWelcomeDialog() {

    List<Note> pinnedNotes =
        HiveHelper.getPinnedNotes();

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor: Color(0xFFFFF8FC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),

          contentPadding: EdgeInsets.all(25),

          content: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              Container(

                padding: EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Color(0xFFF8D5E4),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.auto_awesome,
                  size: 35,
                  color: Color(0xFFD06C9F),
                ),
              ),

              SizedBox(height: 18),

              Text(
                'Hi, Shahd! 🌷',

                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E3440),
                ),
              ),

              SizedBox(height: 8),

              Text(
                'What’s on your mind today?',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF756B73),
                ),
              ),

              SizedBox(height: 5),

              Text(
                'Write it down before it gets away. ✨',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFB47796),
                ),
              ),

              if (pinnedNotes.isNotEmpty) ...[

                SizedBox(height: 20),

                Container(

                  padding: EdgeInsets.all(14),

                  decoration: BoxDecoration(

                    color: Color(0xFFFFEEF6),

                    borderRadius:
                        BorderRadius.circular(16),
                  ),

                  child: Row(

                    children: [

                      Icon(
                        Icons.push_pin,
                        color: Color(0xFFB85C88),
                      ),

                      SizedBox(width: 10),

                      Expanded(

                        child: Text(

                          'You have ${pinnedNotes.length} pinned note${pinnedNotes.length > 1 ? 's' : ''} to remember. 💕',

                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6D5362),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 22),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(

                    backgroundColor:
                        Color(0xFFD98BB6),

                    foregroundColor: Colors.white,

                    padding:
                        EdgeInsets.symmetric(vertical: 14),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  child: Text(
                    'Let’s write something ✨',

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================
  // Add Note
  // =========================

  void showAddNoteDialog() {

    TextEditingController titleController =
        TextEditingController();

    TextEditingController contentController =
        TextEditingController();

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor: Color(0xFFFFF8FC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          title: Text(
            'Create a Note ✨',

            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E3440),
            ),
          ),

          content: SingleChildScrollView(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                TextField(

                  controller: titleController,

                  decoration: InputDecoration(

                    hintText: 'Note title',

                    prefixIcon: Icon(
                      Icons.title,
                      color: Color(0xFFD98BB6),
                    ),

                    filled: true,

                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                TextField(

                  controller: contentController,

                  maxLines: 5,

                  decoration: InputDecoration(

                    hintText:
                        'What are you thinking about?',

                    prefixIcon: Padding(

                      padding:
                          EdgeInsets.only(bottom: 75),

                      child: Icon(
                        Icons.notes,
                        color: Color(0xFFD98BB6),
                      ),
                    ),

                    filled: true,

                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(

              onPressed: () async {

                if (titleController.text.trim().isEmpty ||
                    contentController.text.trim().isEmpty) {
                  return;
                }

                Note note = Note(

                  title:
                      titleController.text.trim(),

                  content:
                      contentController.text.trim(),

                  date: DateTime.now(),
                );

                await HiveHelper.addNote(note);

                setState(() {});

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(

                backgroundColor:
                    Color(0xFFD98BB6),

                foregroundColor: Colors.white,

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),

              child: Text('Save Note'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // Edit Note
  // =========================

  void showEditNoteDialog(int index) {

    Note note =
        HiveHelper.notesBox.getAt(index)!;

    TextEditingController titleController =
        TextEditingController(
      text: note.title,
    );

    TextEditingController contentController =
        TextEditingController(
      text: note.content,
    );

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor: Color(0xFFFFF8FC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),

          title: Text(
            'Edit Note ✏️',

            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF3E3440),
            ),
          ),

          content: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(

                controller: titleController,

                decoration: InputDecoration(

                  hintText: 'Note title',

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(15),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 15),

              TextField(

                controller: contentController,

                maxLines: 5,

                decoration: InputDecoration(

                  hintText: 'Write your note...',

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(15),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: Text('Cancel'),
            ),

            ElevatedButton(

              onPressed: () async {

                if (titleController.text.trim().isEmpty ||
                    contentController.text.trim().isEmpty) {
                  return;
                }

                note.title =
                    titleController.text.trim();

                note.content =
                    contentController.text.trim();

                note.date = DateTime.now();

                await note.save();

                setState(() {});

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(

                backgroundColor:
                    Color(0xFFD98BB6),

                foregroundColor: Colors.white,
              ),

              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // Delete Note
  // =========================

  void deleteNote(int index) {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor:
              Color(0xFFFFF8FC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          title: Text(
            'Delete this note? 🥺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            'This note will be permanently removed.',
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: Text('Cancel'),
            ),

            ElevatedButton(

              onPressed: () async {

                await HiveHelper.deleteNote(index);

                setState(() {});

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),

              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // Delete All
  // =========================

  void deleteAllNotes() {

    if (HiveHelper.notesBox.isEmpty) {
      return;
    }

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          backgroundColor:
              Color(0xFFFFF8FC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          title: Text(
            'Delete all notes? 🥺',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: Text(
            'All your notes will be permanently deleted.',
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: Text('Cancel'),
            ),

            ElevatedButton(

              onPressed: () async {

                await HiveHelper.deleteAllNotes();

                setState(() {});

                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),

              child: Text('Delete All'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // Pin Note
  // =========================

  void togglePin(int index) async {

    await HiveHelper.togglePin(index);

    setState(() {});
  }

  // =========================
  // Build
  // =========================

  @override
  Widget build(BuildContext context) {

    List<Note> allNotes =
        HiveHelper.getAllNotes();

    return Scaffold(

      backgroundColor: Color(0xFFFFF8FC),

      appBar: AppBar(

        backgroundColor:
            Color(0xFFFFF8FC),

        title: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              'My Notes',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E3440),
              ),
            ),

            Text(
              'Your little space for thoughts ✨',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFB47796),
              ),
            ),
          ],
        ),

        actions: [

          PopupMenuButton<String>(

            icon: Icon(
              Icons.more_vert,
              color: Color(0xFF3E3440),
            ),

            onSelected: (value) {

              if (value == 'deleteAll') {
                deleteAllNotes();
              }

              if (value == 'welcome') {
                showWelcomeDialog();
              }
            },

            itemBuilder: (context) => [

              PopupMenuItem(

                value: 'welcome',

                child: Row(
                  children: [

                    Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFD98BB6),
                    ),

                    SizedBox(width: 10),

                    Text('Welcome'),
                  ],
                ),
              ),

              PopupMenuItem(

                value: 'deleteAll',

                child: Row(
                  children: [

                    Icon(
                      Icons.delete_sweep_outlined,
                      color: Colors.redAccent,
                    ),

                    SizedBox(width: 10),

                    Text('Delete All Notes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      body: allNotes.isEmpty

          ? Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Container(

                    padding: EdgeInsets.all(25),

                    decoration: BoxDecoration(

                      color:
                          Color(0xFFF8D5E4),

                      shape: BoxShape.circle,
                    ),

                    child: Icon(

                      Icons.auto_awesome,

                      size: 55,

                      color:
                          Color(0xFFD06C9F),
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(

                    'Nothing here yet 🌷',

                    style: TextStyle(

                      fontSize: 23,

                      fontWeight:
                          FontWeight.bold,

                      color:
                          Color(0xFF3E3440),
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(

                    'Write down whatever is on your mind.',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      color:
                          Color(0xFF756B73),
                    ),
                  ),
                ],
              ),
            )

          : ListView.builder(

              padding:
                  EdgeInsets.fromLTRB(
                20,
                20,
                20,
                100,
              ),

              itemCount: allNotes.length,

              itemBuilder:
                  (context, index) {

                Note note =
                    allNotes[index];

                return NoteCard(

                  note: note,

                  onEdit: () {
                    showEditNoteDialog(index);
                  },

                  onDelete: () {
                    deleteNote(index);
                  },

                  onPin: () {
                    togglePin(index);
                  },
                );
              },
            ),

      floatingActionButton:

          FloatingActionButton.extended(

        onPressed:
            showAddNoteDialog,

        backgroundColor:
            Color(0xFFD98BB6),

        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: Text(
          'New Note',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}