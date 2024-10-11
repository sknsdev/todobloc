import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todobloc/data/models/isar_todo.dart';
import 'package:todobloc/data/repository/isar_todo_repo.dart';
import 'package:todobloc/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  final isarTodoRepo = IsarTodoRepo(isar);
  runApp(MainApp(
    repo: isarTodoRepo,
  ));
}

class MainApp extends StatelessWidget {
  final IsarTodoRepo repo;
  const MainApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: TodoPage(
        repo: repo,
      )),
    );
  }
}
