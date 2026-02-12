import 'package:dio/dio.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';
import 'post_datasource_interface.dart';

class PostsDioDatasource implements PostsDatasourceInterface {
  final Dio dio;

  PostsDioDatasource(this.dio);

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data; // Dio já decodifica JSON
      return jsonList.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar posts');
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts/$id',
    );
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    } else {
      throw Exception('Erro ao buscar post');
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/users/$id',
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Erro ao buscar usuário');
    }
  }
}
