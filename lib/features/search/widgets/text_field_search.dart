import '../logic/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/colors_manager.dart';
import '../../../core/utils/styles_manager.dart';

class TextFieldSearch extends StatefulWidget {
  const TextFieldSearch({super.key});

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return Expanded(
          child: TextField(
            controller: titleController,
            style: StylesManager.black16w500,
            decoration: InputDecoration(
              fillColor: ColorsManager.lightestGrey,
              filled: true,
              prefixIcon: Icon(Icons.search, size: 20.sp),
              contentPadding: const EdgeInsets.all(8),
              hintStyle: StylesManager.gray16w500,

              suffix:
                  titleController.text.isEmpty
                      ? null
                      : GestureDetector(
                        onTap: () {
                          titleController.clear();
                          context.read<FilterCubit>().filterTask('');
                        },
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: ColorsManager.darkGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                        ),
                      ),
              hintText: 'Search',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: ColorsManager.moreLightGrey,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(
                  color: ColorsManager.moreLightGrey,
                  width: 1.w,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                context.read<FilterCubit>().filterTask(value);
              } else {
                context.read<FilterCubit>().filterTask('');
              }
            },
          ),
        );
      },
    );
  }
}
