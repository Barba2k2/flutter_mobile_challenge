import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/post_model.dart';
import 'post_favorite_datasource_interface.dart';

class PostFirestoreDatasource implements PostFavoriteDatasourceInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  PostFirestoreDatasource({
    required this.firestore,
    required this.auth,
  });

  CollectionReference<Map<String, dynamic>> _favoritesRef() {
    final uid = auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuário não autenticado');
    return firestore.collection('users').doc(uid).collection('favorites');
  }

  @override
  Future<void> savePost(PostModel post) async {
    await _favoritesRef().doc(post.id.toString()).set(post.toJson());
  }

  @override
  Future<List<PostModel>> getSavedPosts() async {
    final snapshot = await _favoritesRef().get();
    return snapshot.docs
        .map((doc) => PostModel.fromJson(doc.data()))
        .toList();
  }
}
