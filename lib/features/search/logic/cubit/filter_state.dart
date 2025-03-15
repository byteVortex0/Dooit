part of 'filter_cubit.dart';

@immutable
sealed class FilterState {}

final class FilterInitial extends FilterState {}

final class FilterTasksLoading extends FilterState {}

final class FilterTasksScusses extends FilterState {
  final List<Tasks> tasks;

  FilterTasksScusses({required this.tasks});
}

final class FilterTasksEmpty extends FilterState {}
