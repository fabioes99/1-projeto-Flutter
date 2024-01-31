
import 'package:_1_projeto/model/post.dart';
import 'package:_1_projeto/repositories/posts/posts_repository.dart';
import 'package:_1_projeto/repositories/jsonplaceholder_custom.dart';

class PostsDio implements PostsRepository{
   final JsonPlaceHolderCustonDio jsonPlaceHolderCustonDio ;

   PostsDio(this.jsonPlaceHolderCustonDio);
  @override
  Future<List<PostModel>> getPosts() async{
    final jsonPlaceHolderCustonDio = JsonPlaceHolderCustonDio();
    var response = await jsonPlaceHolderCustonDio.dio.get("/posts");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    }
    return [];
  }

}