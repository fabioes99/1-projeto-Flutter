import 'package:_1_projeto/shared/widgets/card_detail.dart';
import 'package:flutter/material.dart';
import 'package:_1_projeto/repositories/card_detail_repository.dart';

import '../model/card_detail.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  CardDetail? cardDetail;
  var cardDetailtRepository = CardDetailRepository();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

   void carregarDados() async {
    cardDetail = await cardDetailtRepository.get();
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: cardDetail == null 
          ? const LinearProgressIndicator()
          : InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CardDetailPage(cardDetail: cardDetail!,)));
            },
            child: Hero(
              tag: cardDetail!.id,
              child: Card(
                elevation: 16,
                shadowColor: Colors.purple.shade400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network( cardDetail!.url, width: 100,),
                          Text( cardDetail!.title),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}