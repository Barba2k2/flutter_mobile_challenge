import 'package:dartz/dartz.dart';

import '../../../../shared/typedefs.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository_interface.dart';
import '../datasource/auth_datasource_interface.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthDatasourceInterface datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  AsyncResultAuth<UserEntity> getCurrentUser() async {
    try {
      final model = datasource.getCurrentUser();
      if (model == null) {
        return Left(Exception('Usuário não autenticado'));
      }
      return Right(model.toEntity());
    } catch (e) {
      return Left(Exception('Erro ao verificar autenticação: $e'));
    }
  }

  @override
  AsyncResultAuth<UserEntity> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final model = await datasource.loginWithEmail(email, password);
      return Right(
        model.toEntity(),
      );
    } catch (e) {
      return Left(
        Exception('Erro ao fazer login: $e'),
      );
    }
  }

  @override
  AsyncResultAuth<UserEntity> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      final model = await datasource.registerWithEmail(email, password);
      return Right(
        model.toEntity(),
      );
    } catch (e) {
      return Left(
        Exception('Erro ao criar conta: $e'),
      );
    }
  }

  @override
  AsyncResultAuth<UserEntity> signInWithGoogle() async {
    try {
      final model = await datasource.signInWithGoogle();
      return Right(
        model.toEntity(),
      );
    } catch (e) {
      return Left(
        Exception('Erro ao entrar com Google: $e'),
      );
    }
  }

  @override
  AsyncResultAuth<void> signOut() async {
    try {
      await datasource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(
        Exception('Erro ao sair: $e'),
      );
    }
  }
}
