import '../../../../core/extensions/cotext_extension.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/styles_manager.dart';
import '../../logic/get_all_tasks/get_all_tasks_cubit.dart';
import 'build_item_all_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllListTabBar extends StatelessWidget {
  const AllListTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<GetAllTasksCubit>().getAllTasks();
      },
      child: BlocBuilder<GetAllTasksCubit, GetAllTasksState>(
        builder: (context, state) {
          if (state is GetAllTasksLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            );
          } else if (state is GetAllTasksScusses) {
            return ListView.separated(
              itemBuilder:
                  (context, index) =>
                      BuildItemAllLists(tasks: state.tasks[index]),
              separatorBuilder: (context, index) => SizedBox(height: 7.h),
              itemCount: state.tasks.length,
            );
          } else if (state is GetAllTasksEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/svg/todo.svg'),
                  SizedBox(height: 20.h),
                  Text(
                    'Create your first to-do list...',
                    style: StylesManager.black16w500,
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 13.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .pushNamed(
                                  AppRoutes.newList,
                                  arguments:
                                      context
                                          .read<GetAllTasksCubit>()
                                          .emptyTask,
                                )
                                .then((value) {
                                  if (!context.mounted) return;
                                  context
                                      .read<GetAllTasksCubit>()
                                      .getAllTasks();
                                });
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'New List',
                                    style: StylesManager.white15w400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
