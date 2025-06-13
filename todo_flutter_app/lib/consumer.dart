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

  static Future<void> addTodo(String title) async {}

  static Future<void> updateTodo(
    int id,
    String title,
    bool isCompleted,
  ) async {}

  static Future<void> deleteTodo(int id) async {}
}
