import 'package:flutter/material.dart';
import '../consumer.dart';

void showEditTodoDialog(
  BuildContext context,
  dynamic todo,
  VoidCallback refresh,
) {
  final controller = TextEditingController(text: todo['title']);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Editar ToDo'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Novo título'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final newTitle = controller.text.trim();
                  if (newTitle.isNotEmpty) {
                    await TodoApi.updateTodo(
                      todo['id'],
                      newTitle,
                      todo['isCompleted'],
                    );
                    if (context.mounted) {
                      Navigator.pop(context);
                      refresh();
                    }
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        },
      );
    },
  );
}
