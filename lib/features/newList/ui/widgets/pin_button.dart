import '../../logic/cubit/put_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/styles_manager.dart';

class PinButton extends StatelessWidget {
  const PinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PutTasksCubit, PutTasksState>(
      builder: (context, state) {
        final cubit = context.read<PutTasksCubit>();
        return GestureDetector(
          onTap: () {
            cubit.togglePin();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            height: 25.h,
            decoration: BoxDecoration(
              color: cubit.isPinned ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(7.r),
              border: Border.all(color: Colors.black, width: 1.w),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.push_pin_outlined,
                  color: cubit.isPinned ? Colors.white : Colors.black,
                  size: 15.sp,
                ),
                Text(
                  'Pin',
                  style:
                      cubit.isPinned
                          ? StylesManager.white12w500
                          : StylesManager.black12w500,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
