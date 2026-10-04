import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  bool isPinned;

  Note({
    required this.title,
    required this.content,
    required this.date,
    this.isPinned = false,
  });
}