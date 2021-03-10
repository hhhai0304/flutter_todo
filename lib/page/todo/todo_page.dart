import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/component/horizontal_divider.dart';
import 'package:todo_app/core/util/utils.dart';
import 'package:todo_app/model/todo.dart';

import '../../core/base_state.dart';
import 'todo_bloc.dart';

class TodoPage extends StatefulWidget {
  final List<Todo> data;

  const TodoPage(this.data);

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends BaseState<TodoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) {
        final it = widget?.data[index];
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              onTap: () {
                BlocProvider.of<TodoBloc>(context).add(DeleteTodo(it));
              },
            ),
          ],
          child: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  it.status = !it.status;
                  BlocProvider.of<TodoBloc>(context).add(SaveTodo());
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    widget.data[index].status
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    size: 20,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                    text: it.description ?? '',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      right: 12,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (content) {
                    if (!isNullOrEmpty(content)) {
                      it.description = content;
                      BlocProvider.of<TodoBloc>(context).add(SaveTodo());
                      return;
                    }
                    Utils.showToast('error_empty_todo'.getFromResource);
                  },
                  style: TextStyle(
                    decoration: widget.data[index].status
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => HorizontalDivider(),
      itemCount: widget?.data?.length ?? 0,
    );
  }
}
