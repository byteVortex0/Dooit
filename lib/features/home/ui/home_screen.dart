import '../../../core/extensions/cotext_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/styles_manager.dart';
import '../logic/get_all_tasks/get_all_tasks_cubit.dart';
import '../logic/get_pinned_tasks/get_pinned_tasks_cubit.dart';
import 'widgets/all_list_tab_bar.dart';
import 'widgets/pinned_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetAllTasksCubit()..getAllTasks()),
        BlocProvider(
          create: (context) => GetPinnedTasksCubit()..getPinnedTasks(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Dooit', style: StylesManager.black16w500),
          actionsPadding: EdgeInsets.symmetric(horizontal: 10.w),
          leading: Container(
            padding: EdgeInsetsDirectional.only(start: 10.w),
            child: Transform.scale(
              scale: MediaQuery.of(context).size.width / 600,
              child: SvgPicture.asset('assets/images/svg/logo.svg'),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, size: 20.sp),
              onPressed: () {
                context.pushNamed(AppRoutes.search);
              },
            ),
          ],
        ),

        body: Column(
          children: [
            SizedBox(height: 20.h),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: ColorsManager.lightGrey,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                labelStyle: StylesManager.white15w400,
                unselectedLabelColor: Colors.black45,
                tabs: [Tab(text: 'All List'), Tab(text: 'Pinned')],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [const AllListTabBar(), const PinnedTabBar()],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
        floatingActionButton: BlocBuilder<GetAllTasksCubit, GetAllTasksState>(
          builder: (context, state) {
            if (context.read<GetAllTasksCubit>().tasks.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  context
                      .pushNamed(
                        AppRoutes.newList,
                        arguments: context.read<GetAllTasksCubit>().emptyTask,
                      )
                      .then((value) {
                        if (!context.mounted) return;
                        context.read<GetAllTasksCubit>().getAllTasks();
                      });
                },
                backgroundColor: Colors.black,
                shape: const CircleBorder(),
                child: Icon(Icons.add, color: Colors.white),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
