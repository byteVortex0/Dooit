import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/styles_manager.dart';
import '../../logic/get_pinned_tasks/get_pinned_tasks_cubit.dart';
import 'build_item_all_lists.dart';

class PinnedTabBar extends StatelessWidget {
  const PinnedTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<GetPinnedTasksCubit>().getPinnedTasks();
      },
      child: BlocBuilder<GetPinnedTasksCubit, GetPinnedTasksState>(
        builder: (context, state) {
          if (state is GetPinnedTasksLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            );
          } else if (state is GetPinnedTasksScusses) {
            return ListView.separated(
              itemBuilder:
                  (context, index) =>
                      BuildItemAllLists(tasks: state.tasks[index]),
              separatorBuilder: (context, index) => SizedBox(height: 7.h),
              itemCount: state.tasks.length,
            );
          } else if (state is GetPinnedTasksEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/svg/noPinned.svg'),
                  SizedBox(height: 20.h),
                  Text(
                    'Ooops! No pinned list yet...',
                    style: StylesManager.black16w500,
                  ),

                  SizedBox(height: 50.h),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
