import 'package:_1_projeto/pages/dados_cadastrais.dart';
import 'package:_1_projeto/pages/page1teste.dart';
import 'package:_1_projeto/pages/page2teste.dart';
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
        drawer: Drawer( 
          child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
                InkWell(
                  child: Container(
                    width: double.infinity,
                    child: const Text("dados cadatrais")),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DadosCadastrais() ));
                    },
                )
              
              ],
            
          ),
        ),),
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
              Page1Teste(),
              Page2Teste()
              ],),
           ),
          BottomNavigationBar( onTap: (value) {
            controller.jumpToPage(value);
           } ,currentIndex: posicaoPagina,  items: [
            BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "teste", icon: Icon(Icons.add)),
          ]),
         ],
       ),
      
      ),
    );
  }
}