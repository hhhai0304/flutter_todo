import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/app_styles.dart';
import 'package:todo_app/core/component/empty_page.dart';
import 'package:todo_app/core/component/loading_page.dart';
import 'package:todo_app/core/injection/injection.dart';
import 'package:todo_app/page/todo/todo_page.dart';
import 'package:todo_app/repository/todo_repository.dart';

import '../../core/base_state.dart';
import '../../core/util/utils.dart';
import 'todo_bloc.dart';

enum TodoStatus { all, complete, incomplete }

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  final _todoBloc = TodoBloc(Injection().get<TodoRepository>());
  final _currentTabIndex = 0.obs;

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  _refresh() => _todoBloc.add(LoadTodo(_currentTabIndex.value == 0
      ? TodoStatus.all
      : _currentTabIndex.value == 1
          ? TodoStatus.complete
          : TodoStatus.incomplete));

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      cubit: _todoBloc,
      listener: (context, state) {
        if (state is TodoError) {
          showErrorDialog(state.error);
        } else if (state is TodoLoaded) {}
      },
      child: Scaffold(
        backgroundColor: AppColor.pageBackground,
        appBar: AppBar(title: Text('To-do'), centerTitle: false),
        body: BlocBuilder<TodoBloc, TodoState>(
          cubit: _todoBloc,
          buildWhen: (prev, current) => current is! TodoError,
          builder: (context, state) {
            if (state is TodoLoading) {
              return LoadingPage();
            } else if (state is TodoLoaded && !isNullOrEmpty(state.data)) {
              return BlocProvider(
                create: (_) => _todoBloc,
                child: TodoPage(state.data),
              );
            }
            return EmptyPage();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showAddField,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Color(0xFFA8A8A8),
            selectedItemColor: Get.theme.primaryColor,
            backgroundColor: AppColor.pageBackground,
            currentIndex: _currentTabIndex.value,
            onTap: (index) {
              _currentTabIndex.value = index;
              _refresh();
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'all'.getFromResource,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.done),
                label: 'complete'.getFromResource,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_toggle_off),
                label: 'incomplete'.getFromResource,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAddField() {
    final controller = TextEditingController();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
            left: 24, right: 24, top: 24, bottom: GetPlatform.isIOS ? 36 : 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('add_new_todo'.getFromResource, style: AppStyle.dialogTitle),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.check_circle,
                    color: Get.theme.primaryColor,
                  ),
                  onPressed: () {
                    final description = controller.text;
                    if (isNullOrEmpty(description)) {
                      Utils.showToast('error_empty_todo'.getFromResource);
                      return;
                    }
                    Get.back();
                    _addTodo(description);
                  },
                )
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }

  _addTodo(String description) => _todoBloc.add(AddTodo(description));
}
