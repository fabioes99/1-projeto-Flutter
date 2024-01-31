import 'package:_1_projeto/model/comment.dart';
import 'package:_1_projeto/repositories/comments/comment_repository.dart';
import 'package:_1_projeto/repositories/jsonplaceholder_custom.dart';


class CommentsDio implements CommentsRepository{
  final JsonPlaceHolderCustonDio jsonPlaceHolderCustonDio ;

  CommentsDio(this.jsonPlaceHolderCustonDio);
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async{
    final jsonPlaceHolderCustonDio = JsonPlaceHolderCustonDio();
    var response = await jsonPlaceHolderCustonDio.dio.get("/posts/$postId/comments");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    }
    return [];
  }

}