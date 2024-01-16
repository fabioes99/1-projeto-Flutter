import 'package:_1_projeto/model/tarefaSqlite.dart';
import 'package:_1_projeto/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:flutter/material.dart';

class TarefaSqlitePage extends StatefulWidget {
  const TarefaSqlitePage({super.key});

  @override
  State<TarefaSqlitePage> createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  var tarefaSqliteRepository = TarefaSqliteRepository();
  var descricaoController = TextEditingController();
  var _tarefas = <TarefaSqliteModel>[];
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obtertarefas();
  }

  void obtertarefas() async{
    _tarefas = await tarefaSqliteRepository.obterDados(apenasNaoConcluidos);
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
                  await tarefaSqliteRepository.add(TarefaSqliteModel(0, descricaoController.text, false));
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
                      await tarefaSqliteRepository.delete(tarefa.getId());
                      obtertarefas();
                    },
                    key: Key(tarefa.getDescricao()),
                    child: ListTile(
                      title: Text(tarefa.getDescricao()),
                      trailing: Switch( onChanged: ( bool value ) async{
                        tarefa.setConcluido(value);
                        tarefaSqliteRepository.update(tarefa);
                        obtertarefas();
                      }, value: tarefa.getConcluido(),),
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