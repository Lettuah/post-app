import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_stacked/models/post_model.dart';

class PostService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/postsb"),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed with status: ${response.statusCode}");
    }
  }
}
