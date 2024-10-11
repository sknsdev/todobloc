import 'package:isar/isar.dart';
import 'package:todobloc/domain/models/todo_model.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
