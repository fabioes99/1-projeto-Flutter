import 'package:_1_projeto/pages/forum/sala_chat_page.dart';
import 'package:_1_projeto/pages/forum/sala_model.dart';
import 'package:_1_projeto/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SalaWidget extends StatelessWidget {
  final SalaModel salaModel;
  const SalaWidget({super.key, required this.salaModel});

  retornaImagem(int salaId){
    switch (salaId) {
      case 1:
        return AppImages.flutter;
      case 2:
        return AppImages.laravel;  
      case 3:
        return AppImages.linux;    
      case 4:
        return AppImages.mysql;  
      case 5:
        return AppImages.nodejs;  
      case 6:
        return AppImages.php;  
      case 7:
        return AppImages.python;  
      case 8:
        return AppImages.react;
      case 9:
        return AppImages.vue;   
      default:
        return AppImages.flutter; 
    }
  
  }

  @override
  Widget build(BuildContext context) {
    String nickName = 'teste';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SalaChatPage(nickName: nickName, salaId: salaModel.salaId, titulo: salaModel.titulo,)));
            },
            child: Hero(
              tag: salaModel.salaId,
              child: Card(
                elevation: 12,
                shadowColor: Colors.purple.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        retornaImagem(salaModel.salaId),
                        height: 50,
                      ),
                      const SizedBox(width: 32), 
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(salaModel.titulo, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                            Text(salaModel.descricao),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}