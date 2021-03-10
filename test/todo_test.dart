import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/core/injection/injection.dart';
import 'package:todo_app/core/injection/repository_module.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/todo/home_page.dart';
import 'package:todo_app/page/todo/todo_bloc.dart';
import 'package:todo_app/repository/todo_repository.dart';

import 'fake_core_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FakeCoreModule().dependencies();
  RepositoryModule().dependencies();

  group('Todo Bloc', () {
    TodoBloc todoBloc;
    TodoRepository todoRepository;

    setUp(() {
      todoRepository = Injection().get<TodoRepository>();
      todoBloc = TodoBloc(todoRepository);
    });

    tearDown(() {
      todoBloc.close();
    });

    test('Test Init', () {
      expect(todoBloc.state, isA<TodoLoading>());
    });

    test('Test Load Todo', () async {
      todoBloc.add(LoadTodo(TodoStatus.all));
      await expectLater(todoBloc, emitsInOrder(<Todo>[]));
    });

    test('Test Add Todo', () async {
      todoBloc.add(AddTodo('First to-do'));
      await for (var state in todoBloc) {
        if (state is TodoLoaded) {
          expect(state.data.first.description, 'First to-do');
          break;
        }
      }
    });

    test('Test Edit Todo', () async {
      todoBloc.add(AddTodo('First to-do'));
      await for (var state in todoBloc) {
        if (state is TodoLoaded) {
          expect(state.data.first.description, 'First to-do');
          break;
        }
      }
      expect((todoBloc.state as TodoLoaded).data.length, 1);
      (todoBloc.state as TodoLoaded).data.first.description = 'Edited';
      todoBloc.add(SaveTodo());
      await for (var state in todoBloc) {
        if (state is TodoLoaded) {
          expect(state.data.first.description, 'Edited');
          break;
        }
      }
    });

    test('Test Delete Todo', () async {
      todoBloc.add(AddTodo('First to-do'));
      await for (var state in todoBloc) {
        if (state is TodoLoaded) {
          expect(state.data.first.description, 'First to-do');
          break;
        }
      }
      final needToDeleteTodo = (todoBloc.state as TodoLoaded).data.first;
      todoBloc.add(DeleteTodo(needToDeleteTodo));
      await for (var state in todoBloc) {
        if (state is TodoLoaded) {
          expect(state.data.length, 0);
          break;
        }
      }
    });
  });
}
