import 'package:_1_projeto/shared/app_images.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.user2),
          title: const Text("Meu App"),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("ola tudo bem?"),
               Text("08:59"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "menu1"){
                print("vc clicou na opcao 1");
              }
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>( value: "menu1", child: Text("opcao 1") ),
                const PopupMenuItem<String>( value: "menu2", child: Text("opcao 2") )
              ];
            },
          ),
          isThreeLine: true, //adiciona mais espaçamento
        ),
        Image.asset(AppImages.user1),
        Image.asset(AppImages.user2),
        Image.asset(AppImages.user3),
        Image.asset(AppImages.paisagem1),
        Image.asset(AppImages.paisagem2),
        Image.asset(AppImages.paisagem3),
      ],
    );
  }
}