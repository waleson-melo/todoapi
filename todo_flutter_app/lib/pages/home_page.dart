// TODO Implement this library.

import 'package:flutter/material.dart';
import '../consumer.dart';
import '../dialogs/add_todo_dialog.dart';
import '../dialogs/edit_todo_dialog.dart';
import '../widgets/todo_list_tile.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  late Future<List<dynamic>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  void _refreshTodos() {
    setState(() {
      _todosFuture = TodoApi.fetchTodos();
    });
  }

  void _showAddDialog() => showAddTodoDialog(context, _refreshTodos);
  void _showEditDialog(dynamic todo) => showEditTodoDialog(context, todo, _refreshTodos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshTodos,
            tooltip: 'Atualizar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
        tooltip: 'Adicionar ToDo',
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _todosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa encontrada.'));
          } else {
            final todos = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: todos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) => TodoListTile(
                todo: todos[index],
                onEdit: _showEditDialog,
                onDelete: () async {
                  await TodoApi.deleteTodo(todos[index]['id']);
                  _refreshTodos();
                },
                onToggle: (value) async {
                  await TodoApi.updateTodo(todos[index]['id'], todos[index]['title'], value);
                  _refreshTodos();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
