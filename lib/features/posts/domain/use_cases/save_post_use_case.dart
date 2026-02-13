import 'package:dartz/dartz.dart';

import '../../../../shared/typedefs.dart';
import '../entities/post_entity.dart';
import '../repository/post_repository_interface.dart';

class SavePostUseCase {
  final PostRepositoryInterface repository;

  SavePostUseCase(this.repository);

  AsyncResultPosts<void> savePost(PostEntity post) async {
    if (!post.isValid()) {
      return Left(
        Exception('Post inválido'),
      );
    }
    return await repository.savePost(post);
  }
}
