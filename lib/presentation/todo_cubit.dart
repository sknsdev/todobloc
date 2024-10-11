import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/domain/models/todo_model.dart';
import 'package:todobloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo repo;

  TodoCubit(this.repo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await repo.getTodos();
    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch, text: text);
    await repo.newTodo(newTodo);
    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await repo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    final toggledTodo = todo.toggleCoompletion();
    await repo.updateTodo(toggledTodo);
    loadTodos();
  }
} 
