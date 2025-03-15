import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/hive_database.dart';
import '../../../newList/data/model/tasks.dart';

part 'get_pinned_tasks_state.dart';

class GetPinnedTasksCubit extends Cubit<GetPinnedTasksState> {
  GetPinnedTasksCubit() : super(GetPinnedTasksLoading());

  void getPinnedTasks() {
    emit(GetPinnedTasksLoading());

    try {
      final tasksList = HiveDatabase().tasks!.values.toList();

      final pinnedTasks = tasksList.where((task) => task.isPinned).toList();

      if (pinnedTasks.isEmpty) {
        emit(GetPinnedTasksEmpty());
      } else {
        emit(GetPinnedTasksScusses(tasks: pinnedTasks));
      }
    } catch (e) {
      log('error: $e');
    }
  }
}
