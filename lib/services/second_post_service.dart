import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_stacked/models/post_model.dart';

class SecondPostService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> fetchPosts({int start = 0, int limit = 10}) async {
    final uri = Uri.parse("$baseUrl/posts?_start=$start&_limit=$limit");
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }
}
