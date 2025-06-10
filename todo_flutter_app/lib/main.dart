import 'package:flutter/material.dart';
import 'package:todo_flutter_app/consumer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TodoHomePage(),
    );
  }
}

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

  void _showAddDialog() {
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
                _refreshTodos();
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(dynamic todo) {
    final controller = TextEditingController(text: todo['title']);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              if (controller.text.trim().isNotEmpty) {
                await TodoApi.updateTodo(todo['id'], controller.text.trim(), todo['isCompleted']);
                Navigator.pop(context);
                _refreshTodos();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

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
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  leading: Checkbox(
                    value: todo['isCompleted'],
                    onChanged: (value) async {
                      await TodoApi.updateTodo(todo['id'], todo['title'], value!);
                      _refreshTodos();
                    },
                  ),
                  title: Text(
                    todo['title'],
                    style: TextStyle(
                      decoration: todo['isCompleted']
                          ? TextDecoration.lineThrough
                          : null,
                      color: todo['isCompleted'] ? Colors.grey : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showEditDialog(todo),
                        tooltip: 'Editar',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await TodoApi.deleteTodo(todo['id']);
                          _refreshTodos();
                        },
                        tooltip: 'Excluir',
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}