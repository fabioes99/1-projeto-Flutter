import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:_1_projeto/model/firebase/chat.dart';
import 'package:_1_projeto/shared/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatFirebasePage extends StatefulWidget {
  final String nickName;
  const ChatFirebasePage({super.key, required this.nickName});

  @override
  State<ChatFirebasePage> createState() => _ChatFirebasePageState();
}

class _ChatFirebasePageState extends State<ChatFirebasePage> {
  final db = FirebaseFirestore.instance;
  final textoController = TextEditingController(text: '');
  String userId = "";

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Chat"),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: db.collection("chats").orderBy('data_hora').snapshots(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const SizedBox( height: 80, child: CircularProgressIndicator())
                              : ListView(
                                  children: snapshot.data!.docs.map((e) {
                                    var textModel = TextModel.fromJson(
                                        (e.data() as Map<String, dynamic>));
                                    return ChatWidget(
                                        textModel: textModel,
                                        souEu: textModel.userId == userId);
                                  }).toList(),
                                );
                        }),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: textoController,
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none),
                          style: const TextStyle(fontSize: 18),
                        )),
                        IconButton(
                            onPressed: () async {
                              var textModel = TextModel(
                                  nickname: widget.nickName,
                                  text: textoController.text,
                                  userId: userId);
                              await db
                                  .collection("chats")
                                  .add(textModel.toJson());
                              textoController.text = '';
                            },
                            icon: const Icon(Icons.send))
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}