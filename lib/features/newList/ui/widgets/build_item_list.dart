import 'dart:developer';

import '../../logic/cubit/put_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/styles_manager.dart';

class BuildItemList extends StatelessWidget {
  const BuildItemList({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PutTasksCubit, PutTasksState>(
      builder: (context, state) {
        final cubit = context.read<PutTasksCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: MediaQuery.of(context).size.width / 470,
              child: Checkbox(
                value: cubit.todos[index]['isChecked'],
                activeColor: Colors.black,
                onChanged:
                    (value) =>
                        context.read<PutTasksCubit>().toggleTask(value, index),
              ),
            ),
            Expanded(
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent:
                    (event) => context.read<PutTasksCubit>().handleSpaceBackKey(
                      event,
                      index,
                    ),
                child: TextField(
                  controller: cubit.todos[index]['controller'],
                  focusNode: cubit.todos[index]['focusNode'],
                  decoration: InputDecoration(
                    hintText: 'To-do',
                    hintStyle: StylesManager.gray14w400,
                    border: InputBorder.none,
                  ),
                  style: StylesManager.black14w500.copyWith(
                    decoration:
                        cubit.todos[index]['isChecked']
                            ? TextDecoration.lineThrough
                            : null,
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  onChanged: (value) {
                    log('value: $value');
                    if (value.contains('\n')) {
                      context.read<PutTasksCubit>().handleNewLine(value, index);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
