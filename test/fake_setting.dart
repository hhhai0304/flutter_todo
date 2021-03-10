import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/model/todo.dart';

class FakeSetting extends Fake implements Setting {
  final _data = <Todo>[];

  @override
  clearAllData() => _data.clear();

  @override
  saveData(List<Todo> data) {
    _data.clear();
    _data.addAll(data);
  }

  @override
  List<Todo> getData() {
    return _data;
  }

  @override
  clearData() => _data.clear();
}
