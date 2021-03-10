import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:todo_app/core/util/utils.dart';
import 'package:todo_app/model/todo.dart';

import 'constants.dart';

class Setting {
  final _data = 'data';

  GetStorage instance() => GetStorage(SETTINGS_FILE_NAME);

  clearAllData() async => await instance().erase();

  saveData(List<Todo> data) => instance().write(_data, json.encode(data));

  List<Todo> getData() {
    final jsonData = instance().read(_data);
    if (isNullOrEmpty(jsonData)) return null;
    final rawData = json.decode(jsonData) as List<dynamic>;
    return rawData.map<Todo>((it) => Todo.fromJson(it)).toList();
  }

  clearData() => instance().remove(_data);
}
