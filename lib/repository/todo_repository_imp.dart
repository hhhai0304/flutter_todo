import 'package:todo_app/core/injection/injection.dart';
import 'package:todo_app/core/setting.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

class TodoRepositoryImp extends TodoRepository {
  @override
  Future insertAll(List<Todo> data) async {
    Injection().get<Setting>().saveData(data);
  }

  @override
  Future<List<Todo>> selectAll() async {
    return Injection().get<Setting>().getData();
  }
}
