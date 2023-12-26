import 'package:_1_projeto/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:_1_projeto/model/tarefa.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var descricaoController = TextEditingController();
  var _tarefas = <Tarefa>[];
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obtertarefas();
  }

  void obtertarefas() async{
    if(apenasNaoConcluidos){
      _tarefas = await tarefaRepository.listarNaoConcluidas();
    }else{
      _tarefas = await tarefaRepository.listar();
    }
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
                  await tarefaRepository.add(Tarefa(descricaoController.text, false));
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
                      await tarefaRepository.excluir(tarefa.getId());
                      obtertarefas();
                    },
                    key: Key(tarefa.getId()),
                    child: ListTile(
                      title: Text(tarefa.getDescricao()),
                      trailing: Switch( onChanged: ( bool value ) async{
                        await tarefaRepository.alterar(tarefa.getId(), value);
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