part of 'get_all_tasks_cubit.dart';

@immutable
sealed class GetAllTasksState {}

final class GetAllTasksLoading extends GetAllTasksState {}

final class GetAllTasksScusses extends GetAllTasksState {
  final List<Tasks> tasks;

  GetAllTasksScusses({required this.tasks});
}

final class GetAllTasksEmpty extends GetAllTasksState {}
