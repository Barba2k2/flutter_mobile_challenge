import 'dart:convert';
import '../model/user_model.dart';
import 'post_datasource_interface.dart';
import '../model/post_model.dart';
import 'package:http/http.dart' as http;

class PostsHttpDatasource implements PostsDatasourceInterface {
  final http.Client client;

  PostsHttpDatasource(this.client);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar post');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }
}
