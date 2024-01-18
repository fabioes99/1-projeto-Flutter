import '../../model/Comment.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> retornaComentarios(int postId);
}