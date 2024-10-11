import 'package:todobloc/domain/models/todo_model.dart';

abstract class TodoRepo {
  Future<List<Todo>> getTodos();
  Future<void> newTodo(Todo newTodo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}
