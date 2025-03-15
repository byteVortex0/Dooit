part of 'get_pinned_tasks_cubit.dart';

@immutable
sealed class GetPinnedTasksState {}

final class GetPinnedTasksLoading extends GetPinnedTasksState {}

final class GetPinnedTasksScusses extends GetPinnedTasksState {
  final List<Tasks> tasks;

  GetPinnedTasksScusses({required this.tasks});
}

final class GetPinnedTasksEmpty extends GetPinnedTasksState {}
