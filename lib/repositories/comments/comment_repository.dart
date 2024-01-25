import '../../model/comment.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> retornaComentarios(int postId);
}