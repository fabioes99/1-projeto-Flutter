import 'package:_1_projeto/model/Comment.dart';
import 'package:_1_projeto/repositories/comments/comment_repository.dart';
//import 'package:_1_projeto/repositories/comments/implement/comments_dio.dart';
import 'package:_1_projeto/repositories/comments/implement/comments_http.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentsRepository commentsRepository;
  var comments = <CommentModel>[];

  @override
  void initState() {
    super.initState();
     commentsRepository = CommentsHttp();
    carregarDados();
  }

  void carregarDados() async{
    comments = await commentsRepository.retornaComentarios(widget.postId);
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Comentarios do post ${widget.postId}"),),
         body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: comments.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (_, int index) {
                  var comment = comments[index];
                  return Card(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(comment.name.substring(0, 6)),
                            Text(comment.email),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(comment.body),
                      ],
                    ),
                  ));
                }),
         )
        ),
      );
  }
}