import 'package:_1_projeto/model/tarefa_mobx.dart';
import 'package:mobx/mobx.dart';

part 'lista_tarefa_mobx.g.dart';

class ListaTarefaStore = _ListaTarefaStore with _$ListaTarefaStore;

abstract class _ListaTarefaStore with Store {
  ObservableList<TarefaStore> _tarefas = <TarefaStore>[].asObservable();

  @computed
  List<TarefaStore> get tarefas => apenasNaoConluidos
      ? _tarefas.where((element) => !element.concluido).toList()
      : _tarefas.toList();

  @observable
  var _apenasNaoConluidos = Observable(false);

  bool get apenasNaoConluidos => _apenasNaoConluidos.value;

  @action
  void setNaoConcluidos(bool value) {
    _apenasNaoConluidos.value = value;
  }

  @action
  void adicionar(String descricao) {
    _tarefas.add(TarefaStore(descricao, false));
  }

  @action
  void alterar(String id, String descricao, bool concluido) {
    var tarefa = _tarefas.firstWhere((element) => element.id == id);
    tarefa.alterar(descricao, concluido);
  }

  @action
  void excluir(String id) {
    _tarefas.removeWhere((element) => element.id == id);
  }
}