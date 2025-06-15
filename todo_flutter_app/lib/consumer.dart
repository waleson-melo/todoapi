import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoApi {
  static const String baseUrl = 'http://localhost:5064/api/todos';

  static Future<List<dynamic>> fetchTodos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao buscar todos');
    }
  }

  static Future<void> addTodo(String title) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'isCompleted': false}),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao adicionar todo');
    }
  }

  static Future<void> updateTodo(int id, String title, bool isCompleted) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'title': title, 'isCompleted': isCompleted}),
    );
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Erro ao atualizar todo');
    }
  }

  static Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Erro ao deletar todo');
    }
  }
}
