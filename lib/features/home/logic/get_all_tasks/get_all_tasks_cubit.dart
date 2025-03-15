import 'dart:developer';

import '../../../newList/data/model/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/hive_database.dart';

part 'get_all_tasks_state.dart';

class GetAllTasksCubit extends Cubit<GetAllTasksState> {
  GetAllTasksCubit() : super(GetAllTasksLoading());

  final Tasks emptyTask = Tasks(
    id: 'id',
    title: 'title',
    todos: [],
    date: 'date',
    color: 0xff000000,
    isPinned: false,
    selectedLabel: 0,
  );

  List<Tasks> get tasks {
    final List<Tasks> tasks = HiveDatabase().tasks!.values.toList();
    if (tasks.isEmpty) {
      return [];
    }
    return tasks;
  }

  void getAllTasks() {
    emit(GetAllTasksLoading());

    try {
      final tasksList = HiveDatabase().tasks!.values.toList();

      if (tasksList.isEmpty) {
        emit(GetAllTasksEmpty());
      } else {
        emit(GetAllTasksScusses(tasks: tasksList));
      }
    } catch (e) {
      log('error: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    final taskBox = HiveDatabase().tasks!;

    final keyIndex = taskBox.values.toList().indexWhere(
      (task) => task.id == id,
    );

    if (keyIndex != -1) {
      await taskBox.deleteAt(keyIndex);

      log('delete task success');
      getAllTasks();
    } else {
      log('delete task error');
    }
  }
}
