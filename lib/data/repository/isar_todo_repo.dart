import 'package:isar/isar.dart';
import 'package:todobloc/data/models/isar_todo.dart';
import 'package:todobloc/domain/models/todo_model.dart';
import 'package:todobloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();

    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<void> newTodo(Todo newTodo) async {
    final isarTodo = TodoIsar.fromDomain(newTodo);

    await db.writeTxn(() => db.todoIsars.put(isarTodo));
  }

  @override
  Future<void> updateTodo(Todo updatedTodo) async {
    final isarTodo = TodoIsar.fromDomain(updatedTodo);
    await db.writeTxn(() => db.todoIsars.put(isarTodo));
  }
}
