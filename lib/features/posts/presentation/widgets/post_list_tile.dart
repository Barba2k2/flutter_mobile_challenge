import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post_entity.dart';
import '../bloc/post_bloc.dart';
import '../pages/post_detail_page.dart';

class PostListTile extends StatelessWidget {
  final PostEntity post;

  const PostListTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final preview =
        post.body.length > 100
            ? '${post.body.substring(0, 100)}...'
            : post.body;

    return ListTile(
      title: Text(
        post.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          preview.replaceAll('\n', ' '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider.value(
              value: context.read<PostsBloc>(),
              child: PostDetailPage(post: post),
            ),
          ),
        );
      },
    );
  }
}
