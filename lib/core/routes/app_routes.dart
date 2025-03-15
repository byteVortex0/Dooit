import 'base_routes.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/newList/logic/cubit/put_tasks_cubit.dart';
import '../../features/newList/ui/new_list_screen.dart';
import '../../features/onboarding/ui/on_boarding_screen.dart';
import '../../features/search/search_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/newList/data/model/tasks.dart';

class AppRoutes {
  static const onboarding = 'onboarding';
  static const home = 'home';
  static const newList = 'newList';
  static const search = 'search';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case onboarding:
        return BaseRoutes(page: const OnBoardingScreen());
      case home:
        return BaseRoutes(page: const HomeScreen());
      case newList:
        return BaseRoutes(
          page: BlocProvider(
            create: (context) => PutTasksCubit(),
            child: NewListScreen(tasks: args as Tasks),
          ),
        );
      case search:
        return BaseRoutes(page: const SearchScreen());

      default:
        return null;
    }
  }
}
