import 'package:flutter/material.dart';

import '../../../auth/domain/entities/user_entity.dart';
import '../widgets/info_tile.dart';

class AuthorProfilePage extends StatelessWidget {
  final UserEntity user;

  const AuthorProfilePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Autor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: textTheme.headlineSmall,
            ),
            Text(
              '@${user.username}',
              style: textTheme.bodyLarge,
            ),
            const Divider(height: 32),
            InfoTile(
              icon: Icons.email,
              label: 'E-mail',
              value: user.email,
            ),
            // TODO: add phone, address, website, company when UserEntity is expanded
          ],
        ),
      ),
    );
  }
}
