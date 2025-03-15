import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/hive_database.dart';
import '../../../newList/data/model/tasks.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  void filterTask(String title) {
    emit(FilterTasksLoading());
    if (title.isEmpty) {
      emit(FilterTasksEmpty());
      return;
    }
    final tasksList = HiveDatabase().tasks!.values.toList();

    if (tasksList.isEmpty) {
      emit(FilterTasksEmpty());
      return;
    }

    final searchedTasks =
        tasksList
            .where(
              (task) => task.title.toLowerCase().contains(title.toLowerCase()),
            )
            .toList();

    if (searchedTasks.isEmpty) {
      emit(FilterTasksEmpty());
    } else {
      emit(FilterTasksScusses(tasks: searchedTasks));
    }
  }
}
