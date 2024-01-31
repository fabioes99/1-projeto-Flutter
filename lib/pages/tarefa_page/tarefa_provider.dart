import 'package:_1_projeto/repositories/tarefas/tarefa_provider_repository.dart';
import 'package:flutter/material.dart';
import 'package:_1_projeto/model/tarefa_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TarefaProviderPage extends StatelessWidget {
  var tarefaProviderRepository = TarefaProviderRepository();
  var descricaoController = TextEditingController();

  TarefaProviderPage({super.key});

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
                  Provider.of<TarefaProviderRepository>(context, listen: false)
                  .adicionar(Tarefa( descricaoController.text, false));
                  Navigator.pop(context); 
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
                 Consumer<TarefaProviderRepository>(
                   builder: (_, tarefaProviderRepository ,widget) {
                    return Switch(value: tarefaProviderRepository.apenasNaoConcluido, onChanged: (bool value) { 
                       Provider.of<TarefaProviderRepository>(context, listen: false)
                              .apenasNaoConcluido = value;
                      });
                    }
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<TarefaProviderRepository>(
                builder: (_, tarefaProviderRepository ,widget) {
                  return ListView.builder(
                    itemCount: tarefaProviderRepository.tarefas.length,
                    itemBuilder: (BuildContext bc, int index){
                      var tarefa = tarefaProviderRepository.tarefas[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dissmisDirection) async{
                          await tarefaProviderRepository.excluir(tarefa.id);
                          tarefaProviderRepository.tarefas.remove(tarefa);
                        },
                        key: Key(tarefa.descricao),
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Switch( onChanged: ( bool value ) async{
                            tarefa.concluido = value;
                              Provider.of<TarefaProviderRepository>(context, listen: false)
                              .alterar(tarefa);
                          }, value: tarefa.concluido,),
                        ),
                      );
                  });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}