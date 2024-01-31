import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'tarefa_mobx.g.dart';

class TarefaStore = _TarefaStore with _$TarefaStore;

abstract class _TarefaStore with Store {
  String id = UniqueKey().toString();

  @observable
  bool concluido = false;
  
  @observable
  String descricao = '';

  _TarefaStore(this.descricao, this.concluido);

  @action
  void alterar(String newDescricao ,bool newConcluido){
    concluido = newConcluido;
    descricao = newDescricao;
  }
}