import 'core/app/bloc_observer.dart';
import 'core/routes/app_routes.dart';
import 'core/service/hive_database.dart';
import 'core/service/shared_pref/pref_key.dart';
import 'core/service/shared_pref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await HiveDatabase().setup();

  await SharedPref.init();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, child) {
        // ScreenUtil.init(ctx);
        return MaterialApp(
          title: 'Dooit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          initialRoute:
              SharedPref.getBool(PrefKey.onboarding)
                  ? AppRoutes.home
                  : AppRoutes.onboarding,

          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
