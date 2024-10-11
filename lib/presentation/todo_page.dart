import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/domain/repository/todo_repo.dart';
import 'package:todobloc/presentation/todo_bloc.dart';
// import 'package:todobloc/presentation/todo_cubit.dart';
import 'package:todobloc/presentation/todo_view.dart';

class TodoPage extends StatelessWidget {
  final TodoRepo repo;
  const TodoPage({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repo),
      child: const TodoView(),
    );
  }
}
