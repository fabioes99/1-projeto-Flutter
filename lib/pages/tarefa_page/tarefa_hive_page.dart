import 'package:_1_projeto/model/tarefa_hive.dart';
import 'package:_1_projeto/repositories/tarefas/tarefa_hive_repository.dart';
import 'package:flutter/material.dart';
//import 'package:_1_projeto/model/tarefa.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  late TarefaHiveRepository tarefaHiveRepository;
  var descricaoController = TextEditingController();
  var _tarefas = <TarefaHiveModel>[];
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obtertarefas();
  }

  void obtertarefas() async{
    tarefaHiveRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaHiveRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          descricaoController.text = '';
          showDialog(context: context, builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text("Adicionar Tarefas"),
              content: TextField( controller: descricaoController,),
              actions: [
                TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                TextButton(onPressed: () async{ 
                  await tarefaHiveRepository.adicionar(TarefaHiveModel.criar(descricaoController.text, false));
                  Navigator.pop(context); 
                  obtertarefas();
                }, child: const Text('Salvar')),
              ],
            );
          });
        }),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Apenas não concluídos:", style: TextStyle(fontSize: 18),),
                  Switch(value: apenasNaoConcluidos, onChanged: (bool value) { 
                    apenasNaoConcluidos = value;
                    obtertarefas();
                  })
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index){
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dissmisDirection) async{
                      await tarefaHiveRepository.excluir(tarefa);
                      obtertarefas();
                    },
                    key: Key(tarefa.descricao),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch( onChanged: ( bool value ) async{
                        tarefa.concluido = value;
                        tarefaHiveRepository.alterar(tarefa);
                        obtertarefas();
                      }, value: tarefa.concluido,),
                    ),
                  );
              }),
            ),
          ],
        ),
      ),
    );
  }
}