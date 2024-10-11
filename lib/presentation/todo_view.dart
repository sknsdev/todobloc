import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/domain/models/todo_model.dart';
import 'package:todobloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(controller: textController),
              actions: [
                TextButton(
                    onPressed: () => {
                          todoCubit.addTodo(textController.text.toString()),
                          Navigator.of(context).pop()
                        },
                    child: const Text('Save')),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('cancel'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      body: BlocBuilder<TodoCubit, List<Todo>>(builder: (context, state) {
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final todo = state[index];

            return ListTile(
              title: Text(todo.text),
              leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleTodo(todo)),
              trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodo(todo),
                  icon: const Icon(Icons.delete)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTodoBox(context),
          child: const Icon(Icons.add)),
    );
  }
}
