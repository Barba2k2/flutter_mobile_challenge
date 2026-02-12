import '../../domain/entities/user_entity.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String address;
  final String website;
  final String company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.website,
    required this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final addressMap = json['address'] as Map<String, dynamic>?;
    final address = addressMap != null
        ? '${addressMap['street']}, ${addressMap['suite']}, ${addressMap['city']} - ${addressMap['zipcode']}'
        : '';

    final companyMap = json['company'] as Map<String, dynamic>?;
    final company = companyMap != null ? companyMap['name'] as String : '';

    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: (json['phone'] as String?) ?? '',
      address: address,
      website: (json['website'] as String?) ?? '',
      company: company,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      email: email,
      phone: phone,
      address: address,
      website: website,
      company: company,
    );
  }
}
