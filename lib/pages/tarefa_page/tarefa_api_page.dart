import 'package:_1_projeto/model/tarefas_back4app.dart';
import 'package:_1_projeto/repositories/back4app/tarefas_back4app_repository.dart';
import 'package:flutter/material.dart';

class TarefaApiPage extends StatefulWidget {
  const TarefaApiPage({super.key});

  @override
  State<TarefaApiPage> createState() => _TarefaApiPageState();
}

class _TarefaApiPageState extends State<TarefaApiPage> {
  var tarefaApiRepository = TarefasBack4appRepository();
  var descricaoController = TextEditingController();
  var _tarefas = TarefasBack4AppModel([]);
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obtertarefas();
  }

  void obtertarefas() async{
    setState(() {
      carregando = true;
    });
    _tarefas = await tarefaApiRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas via API'),),
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
                  tarefaApiRepository.post(Tarefa.criar( descricaoController.text, false));
                  Navigator.pop(context); 
                  obtertarefas();
                  setState(() {});
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
            carregando ? const CircularProgressIndicator() :
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.tarefas.length,
                itemBuilder: (BuildContext bc, int index){
                  var tarefa = _tarefas.tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dissmisDirection) async{
                      await tarefaApiRepository.delete(tarefa.objectId);
                      obtertarefas();
                    },
                    key: Key(tarefa.objectId),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch( onChanged: ( bool value ) async{
                        tarefa.concluido = value;
                        await tarefaApiRepository.update(tarefa);
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