import 'package:flutter/material.dart';
import 'package:_1_projeto/model/tarefa_provider.dart';

class TarefaProviderRepository extends ChangeNotifier{
  final _tarefas = <Tarefa>[];
  var _apenasNaoConcluido = false;

  set apenasNaoConcluido(bool value){
    _apenasNaoConcluido = value;
     notifyListeners();
  }

  bool get apenasNaoConcluido => _apenasNaoConcluido;

  get tarefas => _apenasNaoConcluido ? _tarefas.where((element) => !element.concluido).toList() : _tarefas;
  

  adicionar(Tarefa tarefa){
    _tarefas.add(tarefa);
    notifyListeners();
  }

  alterar(Tarefa tarefa){
    _tarefas.where((element) => element.id == tarefa.id).first.concluido = tarefa.concluido;
    notifyListeners();
  }

  excluir(String id){
    _tarefas.remove(
      _tarefas.where((element) => element.id == id).first
    );
    notifyListeners();
  }
}