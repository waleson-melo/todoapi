import 'package:flutter/material.dart';
import '../consumer.dart';

void showAddTodoDialog(BuildContext context, VoidCallback refresh) {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Adicionar ToDo'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Título da tarefa'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.text.trim().isNotEmpty) {
              await TodoApi.addTodo(controller.text.trim());
              Navigator.pop(context);
              refresh();
            }
          },
          child: const Text('Adicionar'),
        ),
      ],
    ),
  );
}
