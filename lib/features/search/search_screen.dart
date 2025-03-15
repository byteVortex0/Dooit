import '../../core/extensions/cotext_extension.dart';
import '../home/logic/get_all_tasks/get_all_tasks_cubit.dart';
import '../home/ui/widgets/build_item_all_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/styles_manager.dart';
import '../home/logic/get_pinned_tasks/get_pinned_tasks_cubit.dart';
import 'logic/cubit/filter_cubit.dart';
import 'widgets/text_field_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => GetAllTasksCubit()),
        BlocProvider(create: (context) => GetPinnedTasksCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const TextFieldSearch(),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel', style: StylesManager.black16w500),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocBuilder<FilterCubit, FilterState>(
                    builder: (context, state) {
                      if (state is FilterTasksLoading) {
                        return Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.black,
                          ),
                        );
                      } else if (state is FilterTasksScusses) {
                        return ListView.separated(
                          itemBuilder:
                              (context, index) =>
                                  BuildItemAllLists(tasks: state.tasks[index]),
                          separatorBuilder:
                              (context, index) => SizedBox(height: 7.h),
                          itemCount: state.tasks.length,
                        );
                      } else if (state is FilterTasksEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No results',
                                style: StylesManager.black20w600,
                              ),
                            ],
                          ),
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
