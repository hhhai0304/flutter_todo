import 'package:bloc/bloc.dart';
import 'package:todo_app/core/util/logger.dart';
import 'package:todo_app/core/util/utils.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/repository/todo_repository.dart';

import 'home_page.dart';

//region EVENT
abstract class TodoEvent {}

class LoadTodo extends TodoEvent {
  final TodoStatus type;

  LoadTodo(this.type);
}

class AddTodo extends TodoEvent {
  final String description;

  AddTodo(this.description);
}

class SaveTodo extends TodoEvent {}

class DeleteTodo extends TodoEvent {
  final Todo todo;

  DeleteTodo(this.todo);
}
//endregion

//region STATE
abstract class TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> data;

  TodoLoaded(this.data);
}

class TodoError extends TodoState {
  final String error;

  TodoError(this.error);
}
//endregion

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  final _allTodo = <Todo>[];
  var _status = TodoStatus.all;

  TodoBloc(this.todoRepository) : super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(event) async* {
    if (event is LoadTodo) {
      yield* _mapLoadTodoToState(event);
    } else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is SaveTodo) {
      yield* _mapSaveTodoToState();
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    }
  }

  Stream<TodoState> _mapLoadTodoToState(LoadTodo event) async* {
    _status = event.type;
    try {
      final data = await todoRepository.selectAll();
      if (isNullOrEmpty(data)) {
        yield TodoLoaded([]);
      } else {
        _allTodo.clear();
        _allTodo.addAll(data);
        yield TodoLoaded(_filter());
      }
    } catch (e) {
      Logger.e('TodoBloc -> _mapLoadTodoToState()', '$e');
      yield TodoError('$e');
    }
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    _allTodo.add(Todo(code: Utils.getGuid(), description: event.description));
    yield* _mapSaveTodoToState();
  }

  Stream<TodoState> _mapSaveTodoToState() async* {
    yield TodoLoaded(_filter());
    try {
      await todoRepository.insertAll(_allTodo);
    } catch (e) {
      Logger.e('TodoBloc -> _mapSaveTodoToState()', '$e');
      yield TodoError('$e');
    }
  }

  Stream<TodoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _allTodo.remove(event.todo);
    yield* _mapSaveTodoToState();
  }

  List<Todo> _filter() {
    final filteredData = <Todo>[];
    switch (_status) {
      case TodoStatus.all:
        filteredData.addAll(_allTodo);
        break;
      case TodoStatus.complete:
        filteredData.addAll(_allTodo.where((it) => it.status));
        break;
      case TodoStatus.incomplete:
        filteredData.addAll(_allTodo.where((it) => !it.status));
        break;
    }
    return filteredData;
  }
}
