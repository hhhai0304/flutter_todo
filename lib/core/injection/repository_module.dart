import 'package:get/get.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/repository/todo_repository_imp.dart';

import 'injection.dart';

class RepositoryModule extends AbstractModule {
  @override
  dependencies() {
    Get.put<TodoRepository>(TodoRepositoryImp());
  }
}
