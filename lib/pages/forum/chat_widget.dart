import 'package:_1_projeto/pages/forum/mensagens_model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final MensagemModel mensagemModel;
  final bool souEu;
  const ChatWidget({super.key, required this.mensagemModel, required this.souEu});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: souEu ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: souEu ? Colors.blue : Colors.orange,
            borderRadius: BorderRadius.circular(10)),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mensagemModel.nickname ,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 15,),
                  Text(
                    UtilData.obterHoraHHMM ( mensagemModel.dataHora ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ]
              ), 
              Text(
                mensagemModel.text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}