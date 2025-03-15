import '../../../core/extensions/cotext_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/styles_manager.dart';
import '../data/model/tasks.dart';
import '../logic/cubit/put_tasks_cubit.dart';
import 'widgets/build_item_list.dart';
import 'widgets/choose_label.dart';
import 'widgets/pin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewListScreen extends StatefulWidget {
  const NewListScreen({super.key, required this.tasks});

  final Tasks tasks;

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  TextEditingController titleController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    if (widget.tasks.id != 'id') {
      titleController.text = widget.tasks.title;
      context.read<PutTasksCubit>().todos.clear();
      for (var element in widget.tasks.todos) {
        context.read<PutTasksCubit>().todos.add({
          'isChecked': element.isChecked,
          'controller': TextEditingController(text: element.text),
          'focusNode': FocusNode(),
        });
      }
      context.read<PutTasksCubit>().selected = widget.tasks.selectedLabel;
      context.read<PutTasksCubit>().isPinned = widget.tasks.isPinned;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await addTaskToDB(context, context.read<PutTasksCubit>().todos);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [PinButton()],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 20.sp),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: BlocBuilder<PutTasksCubit, PutTasksState>(
              builder: (context, state) {
                final todos = context.read<PutTasksCubit>().todos;
                return CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: StylesManager.gray24w500,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                            ),
                            focusNode: focusNode,
                            style: StylesManager.black24w500,
                            onSubmitted: (value) {
                              todos[0]['focusNode'].requestFocus();
                            },
                          ),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder:
                                  (context, index) =>
                                      BuildItemList(index: index),
                              itemCount: todos.length,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Divider(thickness: 1.w, color: Colors.black),
                          SizedBox(height: 20.h),
                          ChooseLabel(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTaskToDB(
    BuildContext context,
    List<Map<String, dynamic>> todos,
  ) async {
    List<TodoModel> todoList =
        todos
            .where((todo) => todo['controller'].text.isNotEmpty)
            .map(
              (todo) => TodoModel(
                text: todo['controller'].text,
                isChecked: todo['isChecked'],
              ),
            )
            .toList();

    if (todoList.isNotEmpty) {
      final cubit = context.read<PutTasksCubit>();
      await cubit.addOrUpdateTask(
        id: widget.tasks.id,
        title: titleController.text,
        todos: todoList,
        isPinned: cubit.isPinned,
        selectedLabel: cubit.selected,
      );
    }

    if (!context.mounted) return;
    context.pushNamedAndRemoveUntil(AppRoutes.home);
  }
}
