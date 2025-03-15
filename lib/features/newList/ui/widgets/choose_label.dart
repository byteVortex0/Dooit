import '../../logic/cubit/put_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/styles_manager.dart';

class ChooseLabel extends StatelessWidget {
  const ChooseLabel({super.key});

  final List<String> labels = const ['Personal', 'Work', 'Finance', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Choose a label', style: StylesManager.black20w600)],
        ),
        SizedBox(height: 20.h),
        Row(
          children: List.generate(
            4,
            (index) => buildType(type: labels[index], index: index),
          ),
        ),
      ],
    );
  }

  Widget buildType({required String type, required int index}) {
    return BlocBuilder<PutTasksCubit, PutTasksState>(
      builder: (context, state) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<PutTasksCubit>().selectedLabel(index);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.w),
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color:
                    index == context.read<PutTasksCubit>().selected
                        ? Colors.black
                        : ColorsManager.darkerGrey,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Text(type, style: StylesManager.white15w400),
              ),
            ),
          ),
        );
      },
    );
  }
}
