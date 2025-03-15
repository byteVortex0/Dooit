import 'package:hive_flutter/adapters.dart';

import '../../features/newList/data/model/tasks.dart';

class HiveDatabase {
  HiveDatabase._();

  static final HiveDatabase instance = HiveDatabase._();

  factory HiveDatabase() => instance;

  Box<Tasks>? tasks;
  Box<TodoModel>? todos;

  Future<void> setup() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TasksAdapter());
    Hive.registerAdapter(TodoAdapter());

    tasks = await Hive.openBox<Tasks>('tasksBox');
    todos = await Hive.openBox<TodoModel>('todosBox');
  }

  Future<void> clearAllBoxs() async {
    await tasks!.clear();
    await todos!.clear();
  }
}
