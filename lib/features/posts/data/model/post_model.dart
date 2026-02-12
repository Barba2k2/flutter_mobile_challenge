import '../../domain/entities/post_entity.dart';

class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Cria um PostModel (model) a partir de um JSON
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  PostEntity toEntity() {
    // Converte o modelo para a entidade
    return PostEntity(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }
}
