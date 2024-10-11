// Step 1: Define the Todo Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/domain/models/todo_model.dart';
import 'package:todobloc/domain/repository/todo_repo.dart';

//EVENTS
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String text;
  AddTodo(this.text);
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  DeleteTodo(this.todo);
}

class ToggleTodo extends TodoEvent {
  final Todo todo;
  ToggleTodo(this.todo);
}

//BLOC
//Вместо переключения состояния - всегда список тудушек
class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  final TodoRepo repo;

  TodoBloc(this.repo) : super([]) {
    on<LoadTodos>((event, emit) async {
      final todoList = await repo.getTodos();
      emit(todoList);
    });

    on<AddTodo>((event, emit) async {
      final newTodo =
          Todo(id: DateTime.now().millisecondsSinceEpoch, text: event.text);
      await repo.newTodo(newTodo);
      add(LoadTodos());
    });

    on<DeleteTodo>((event, emit) async {
      await repo.deleteTodo(event.todo);
      add(LoadTodos());
    });

    on<ToggleTodo>((event, emit) async {
      final toggledTodo = event.todo.toggleCoompletion();
      await repo.updateTodo(toggledTodo);
      add(LoadTodos());
    });

//init
    add(LoadTodos());
  }
}
