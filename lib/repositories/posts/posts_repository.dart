import 'package:_1_projeto/model/post.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}