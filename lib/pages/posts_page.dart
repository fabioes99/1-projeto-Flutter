import 'package:_1_projeto/main.dart';
import 'package:_1_projeto/pages/comments_page.dart';
//import 'package:_1_projeto/repositories/posts/implement/posts_dio.dart';
import 'package:flutter/material.dart';
import 'package:_1_projeto/model/post.dart';
import '../repositories/posts/posts_repository.dart';
//import '../repositories/posts/implement/posts_http.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var postsRepository = getIt<PostsRepository>();
  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    posts = await postsRepository.getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) {
            var post = posts[index];
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: InkWell(
                  onTap: (){ 
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => 
                      CommentsPage(postId: post.id))
                    );
                  },
                  child: Card(
                    child: Container(
                      padding:const  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            post.body,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }),
    ));
  }
}