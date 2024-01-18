
import 'package:_1_projeto/model/post.dart';
import 'package:_1_projeto/repositories/posts/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDio implements PostsRepository{
  @override
  Future<List<PostModel>> getPosts() async{
    final dio = Dio();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    }
    return [];
  }

}