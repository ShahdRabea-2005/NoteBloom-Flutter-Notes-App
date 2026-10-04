
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/note.dart';
import 'widgets/welcome_widget.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox<Note>('notes');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'My Notes',

      theme: ThemeData(

        scaffoldBackgroundColor:
            Color(0xFFFFF8FC),

        primaryColor:
            Color(0xFFD98BB6),

        fontFamily: 'Arial',
      ),

      home: WelcomeWidget(),
    );
  }
}
