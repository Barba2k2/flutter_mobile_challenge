import 'package:equatable/equatable.dart';

import '../../domain/entities/post_entity.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsRequested extends PostsEvent {} // Evento específico: carregar posts

class LoadPostByIdRequested extends PostsEvent { // Evento com parâmetro
  final int id;
  const LoadPostByIdRequested(this.id);

  @override
  List<Object> get props => [id];
}

class SavePostRequested extends PostsEvent {
  final PostEntity post;
  const SavePostRequested(this.post);

  @override
  List<Object> get props => [post];
}