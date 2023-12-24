import 'package:_1_projeto/model/card_detail.dart';
import 'package:flutter/material.dart';

class CardDetailPage extends StatelessWidget {
  final CardDetail cardDetail;
  const CardDetailPage({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: SafeArea(
        child: Scaffold(
          body:  Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close) ),
                    Image.network(cardDetail.url, width: 200,),
                   Text( cardDetail.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700) ),
                    Expanded(
                      child: Text(textAlign: TextAlign.center, "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of 'de Finibus Bonorum et Malorum' (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, 'Lorem ipsum dolor sit amet..', comes from a line in section 1.10.32."))
                ],
              ),      
            ),
          ),
        ),
      ),
    );
  }
}