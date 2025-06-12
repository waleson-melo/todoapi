import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  final dynamic todo;
  final Function(dynamic) onEdit;
  final VoidCallback onDelete;
  final Function(bool) onToggle;

  const TodoListTile({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo['isCompleted'],
        onChanged: (value) => onToggle(value!),
      ),
      title: Text(
        todo['title'],
        style: TextStyle(
          decoration:
              todo['isCompleted'] ? TextDecoration.lineThrough : null,
          color: todo['isCompleted'] ? Colors.grey : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => onEdit(todo),
            tooltip: 'Editar',
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
            tooltip: 'Excluir',
          ),
        ],
      ),
    );
  }
}
