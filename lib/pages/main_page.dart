import 'package:_1_projeto/pages/IMC_page.dart';
import 'package:_1_projeto/pages/card_page.dart';
//import 'package:_1_projeto/pages/image_assets.dart';
import 'package:_1_projeto/pages/list_view.dart';
import 'package:_1_projeto/pages/list_view_horizontal.dart';
//import 'package:_1_projeto/pages/tarefa_page/tarefa_hive_page.dart';
import 'package:_1_projeto/pages/tarefa_page/tarefa_sqlite.dart';
import 'package:_1_projeto/pages/consulta_cep.dart';
import 'package:_1_projeto/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
       appBar: AppBar(title: const Text('meu app bar'),),
       body: Column(
         children: [
           Expanded(
             child: PageView( 
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  posicaoPagina = value;
                });
              },
              children: const [
              CardPage(),
              //ImageAssetsPage(),
              ImcPage(),
              ListViewPage(),
              ListViewHorizontal(),
              TarefaSqlitePage(),
              ConsultaCep()
              ],),
           ),
           BottomNavigationBar( 
            type: BottomNavigationBarType.fixed,// passou de 3 paginas e necessario adicionar essa linha
            onTap: (value) {
            controller.jumpToPage(value);
           } ,currentIndex: posicaoPagina,  items: const [
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "IMC", icon: Icon(Icons.add)),
            BottomNavigationBarItem(label: "ListView", icon: Icon(Icons.abc)),
            BottomNavigationBarItem(label: "Page4", icon: Icon(Icons.person)),
            BottomNavigationBarItem(label: "Tarefas", icon: Icon(Icons.list)),
            BottomNavigationBarItem(label: "HTTP", icon: Icon(Icons.get_app_rounded)),
          ]),
         ],
       ),
      
      ),
    );
  }
}