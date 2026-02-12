import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    //Cria um UserModel (model) a partir de um JSON
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  UserEntity toEntity() {
    //Converte o modelo para a entidade
    return UserEntity(
      id: id,
      name: name,
      username: username,
      email: email,
      password: password,
    );
  }
}
