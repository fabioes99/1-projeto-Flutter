import 'package:_1_projeto/pages/IMC_page.dart';
import 'package:_1_projeto/pages/card_page.dart';
//import 'package:_1_projeto/pages/image_assets.dart';
import 'package:_1_projeto/pages/list_view.dart';
import 'package:_1_projeto/pages/list_view_horizontal.dart';
//import 'package:_1_projeto/pages/tarefa_page/tarefa_hive_page.dart';
import 'package:_1_projeto/pages/tarefa_page/tarefa_sqlite.dart';
import 'package:_1_projeto/pages/cep_consulta_page.dart';
import 'package:_1_projeto/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);
  }
  
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      drawer: const MyDrawer(),
       appBar: AppBar(title: const Text('meu app bar'),),
       body: 
       TabBarView(
        controller: tabController,
        children: const [
          CardPage(),
          ImcPage(),
          ListViewPage(),
          ListViewHorizontal(),
          TarefaSqlitePage(),
          ConsultaCep()
        ],
      ),
       bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.balance, title: 'IMC'),
          TabItem(icon: Icons.list, title: 'ListView'),
          TabItem(icon: Icons.photo, title: 'Page4'),
          TabItem(icon: Icons.task, title: 'Tarefas'),
          TabItem(icon: Icons.place, title: 'CEP'),
        ],
        onTap: (int i) => tabController.index = i,
        controller: tabController,
      )
      ),
    );
  }
}