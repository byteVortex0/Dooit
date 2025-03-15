part of 'put_tasks_cubit.dart';

@immutable
sealed class PutTasksState {}

final class TasksInitial extends PutTasksState {}

final class AddOrUpdateTask extends PutTasksState {}

final class AddNewLineTask extends PutTasksState {}

final class ToggleTask extends PutTasksState {}

final class RemoveEmptyTask extends PutTasksState {}

final class SelectedLabel extends PutTasksState {}

final class TogglePin extends PutTasksState {}
