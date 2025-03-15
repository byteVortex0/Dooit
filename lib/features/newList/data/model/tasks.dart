import 'package:hive_flutter/adapters.dart';

part 'tasks.g.dart';

@HiveType(typeId: 0, adapterName: 'TasksAdapter')
class Tasks extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<TodoModel> todos;

  @HiveField(3)
  final String date;

  @HiveField(4)
  final int color;

  @HiveField(5)
  bool isPinned;

  @HiveField(6)
  int selectedLabel;

  Tasks({
    required this.id,
    required this.title,
    required this.todos,
    required this.date,
    required this.color,
    required this.isPinned,
    required this.selectedLabel,
  });
}

@HiveType(typeId: 1, adapterName: 'TodoAdapter')
class TodoModel extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isChecked;

  TodoModel({required this.text, required this.isChecked});
}
