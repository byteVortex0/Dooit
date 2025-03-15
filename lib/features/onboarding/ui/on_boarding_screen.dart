import '../../../core/extensions/cotext_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/service/shared_pref/pref_key.dart';
import '../../../core/service/shared_pref/shared_pref.dart';
import '../../../core/utils/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/svg/black_logo.svg'),
                  SizedBox(height: 20.h),
                  Text('Dooit', style: StylesManager.white39w600),
                  SizedBox(height: 10.h),
                  Text(
                    'Write what you need\nto do. Everyday.',
                    style: StylesManager.white18w400,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Container(
              width: 200.w,
              height: 50.h,
              margin: EdgeInsets.only(bottom: 70.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await SharedPref.setBool(PrefKey.onboarding, true);
                  if (!context.mounted) return;
                  context.pushReplacementNamed(AppRoutes.home);
                },
                child: Text('Continue', style: StylesManager.black16w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
