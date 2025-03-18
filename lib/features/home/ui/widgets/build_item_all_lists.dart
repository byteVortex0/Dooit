import '../../../../core/extensions/cotext_extension.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../logic/get_all_tasks/get_all_tasks_cubit.dart';
import '../../logic/get_pinned_tasks/get_pinned_tasks_cubit.dart';
import '../../../newList/data/model/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/app_routes.dart';

class BuildItemAllLists extends StatelessWidget {
  const BuildItemAllLists({super.key, required this.tasks});

  final Tasks tasks;
  final List<String> labels = const ['Personal', 'Work', 'Finance', 'Other'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.newList, arguments: tasks);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
        decoration: BoxDecoration(
          color: Color(tasks.color),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tasks.title,
                  style: StylesManager.black20w600.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Center(
                        child: Text(
                          labels[tasks.selectedLabel],
                          style: StylesManager.white12w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.h),

                    Icon(Icons.calendar_today_outlined, size: 15.sp),
                    SizedBox(width: 5.h),

                    Text(tasks.date, style: StylesManager.black12w500),
                  ],
                ),
              ],
            ),

            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<GetAllTasksCubit, GetAllTasksState>(
                  builder: (context, state) {
                    return BlocBuilder<
                      GetPinnedTasksCubit,
                      GetPinnedTasksState
                    >(
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () async {
                            await context.read<GetAllTasksCubit>().deleteTask(
                              tasks.id,
                            );
                            if (!context.mounted) return;
                            context
                                .read<GetPinnedTasksCubit>()
                                .getPinnedTasks();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                            size: 15.sp,
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                if (tasks.isPinned)
                  Transform.rotate(
                    angle: 45 * (3.141592653589793 / 180),
                    child: Icon(
                      Icons.push_pin,
                      color: Colors.black,
                      size: 15.sp,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
