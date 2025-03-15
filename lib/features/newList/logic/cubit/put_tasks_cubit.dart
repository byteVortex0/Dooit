import 'dart:developer';

import '../../../../core/service/hive_database.dart';
import '../../../../core/utils/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/tasks.dart';

part 'put_tasks_state.dart';

final uuid = Uuid();

class PutTasksCubit extends Cubit<PutTasksState> {
  PutTasksCubit() : super(TasksInitial());

  // add or update task
  Future<void> addOrUpdateTask({
    required String id,
    required String title,
    required List<TodoModel> todos,
    required bool isPinned,
    required int selectedLabel,
  }) async {
    try {
      final taskBox = HiveDatabase().tasks!;
      final existingTask = taskBox.values.firstWhere(
        (task) => task.id == id,
        orElse:
            () => Tasks(
              id: 'id',
              title: 'title',
              todos: [],
              date: 'date',
              color: 0xffffffff,
              isPinned: false,
              selectedLabel: 0,
            ),
      );

      if (existingTask.id != 'id') {
        existingTask.title = title;
        existingTask.todos = todos;
        existingTask.isPinned = isPinned;
        existingTask.selectedLabel = selectedLabel;
        await taskBox.put(existingTask.key, existingTask);
        log('update task');
      } else {
        int newColor;
        if (taskBox.isNotEmpty) {
          do {
            newColor = getRandomColor();
          } while (taskBox.values.last.color == newColor);
        } else {
          newColor = getRandomColor();
        }
        await taskBox.add(
          Tasks(
            id: uuid.v4(),
            title: title,
            date: formatDate(DateTime.now()),
            todos: todos,
            color: newColor,
            isPinned: isPinned,
            selectedLabel: selectedLabel,
          ),
        );
        log('add new task');
      }

      emit(AddOrUpdateTask());
    } catch (e) {
      log('error: $e');
    }
  }

  int getRandomColor() {
    return (ColorsManager.backgroundColors.toList()..shuffle()).first;
  }

  String formatDate(DateTime date) {
    return DateFormat('d-M-yyyy').format(date);
  }

  List<Map<String, dynamic>> todos = [
    {
      'isChecked': false,
      'controller': TextEditingController(),
      'focusNode': FocusNode(),
    },
  ];

  // handle new line
  void handleNewLine(String value, int index) {
    if (value.trim().isEmpty) return;

    log('handle new line');

    String newText = value.replaceAll('\n', '');
    todos[index]['controller'].text = newText;

    addNewTask(index + 1);
    emit(AddNewLineTask());
  }

  void addNewTask(int index) {
    final newItem = {
      'isChecked': false,
      'controller': TextEditingController(),
      'focusNode': FocusNode(),
    };

    todos.insert(index, newItem);

    Future.delayed(Duration(milliseconds: 100), () {
      todos[index]['focusNode'].requestFocus();
    });
  }

  // toggle task
  void toggleTask(bool? value, int index) {
    if (todos[index]['controller'].text.isEmpty) {
      value = false;
      return;
    }

    todos[index]['isChecked'] = value ?? false;
    emit(ToggleTask());
  }

  // remove empty task
  void handleSpaceBackKey(KeyEvent event, int index) {
    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      if (todos[index]['controller'].text.isEmpty && index != 0) {
        removeTask(index);
        emit(RemoveEmptyTask());
      }
    }
  }

  void removeTask(int index) {
    FocusNode? nextFocusNode;
    if (index > 0) {
      nextFocusNode = todos[index - 1]['focusNode'];
    }

    todos[index]['controller'].dispose();
    todos[index]['focusNode'].dispose();
    todos.removeAt(index);

    if (nextFocusNode != null) {
      Future.delayed(Duration.zero, () {
        nextFocusNode!.requestFocus();
      });
    }
  }

  int selected = 0;
  // choose label
  void selectedLabel(int index) {
    selected = index;
    emit(SelectedLabel());
  }

  bool isPinned = false;
  void togglePin() {
    isPinned = !isPinned;
    emit(TogglePin());
  }

  @override
  Future<void> close() {
    for (var element in todos) {
      element['controller'].dispose();
      element['focusNode'].dispose();
    }
    return super.close();
  }
}
