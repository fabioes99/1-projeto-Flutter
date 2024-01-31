import 'package:flutter/material.dart';
import 'package:_1_projeto/model/lista_tarefa_mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// ignore: must_be_immutable
class TarefaMobxPage extends StatelessWidget {
  var tarefaMobxStore = ListaTarefaStore();
  var descricaoController = TextEditingController();

  TarefaMobxPage({super.key});

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
                 tarefaMobxStore.adicionar(descricaoController.text);
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
            const Text("Tarefas Mobx", style: TextStyle(fontSize: 22),),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Apenas não concluídos:", style: TextStyle(fontSize: 18),),
                  Observer(builder: (_) {
                      return Switch(
                          value: tarefaMobxStore.apenasNaoConluidos,
                          onChanged: tarefaMobxStore.setNaoConcluidos);
                    })
                ],
              ),
            ),
            Expanded(
              child: Observer(
                builder: (context) {
                  return ListView.builder(
                    itemCount: tarefaMobxStore.tarefas.length,
                    itemBuilder: (BuildContext bc, int index){
                      var tarefa = tarefaMobxStore.tarefas[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dissmisDirection) {
                          tarefaMobxStore.excluir(tarefa.id);
                          tarefaMobxStore.tarefas.remove(tarefa);
                        },
                        key: Key(tarefa.descricao),
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Observer(
                            builder: (context) {
                              return Switch( 
                                value: tarefaMobxStore.apenasNaoConluidos,
                                onChanged: ( bool value ) {
                                 tarefaMobxStore.setNaoConcluidos(value);
                              }, );
                            }
                          ),
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