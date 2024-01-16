import 'package:hive/hive.dart';
import 'package:_1_projeto/model/tarefa_hive.dart';

class TarefaHiveRepository{
   static late Box _box;

   TarefaHiveRepository._criar();

  static Future<TarefaHiveRepository> carregar() async {
    if (Hive.isBoxOpen('tarefas')) {
      _box = Hive.box('tarefas');
    } else {
      _box = await Hive.openBox('tarefas');
    }
    return TarefaHiveRepository._criar();
  }

  adicionar(TarefaHiveModel tarefaHiveModel) {
      _box.add(tarefaHiveModel);
  }

  alterar(TarefaHiveModel tarefaHiveModel) {
     tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
       return _box.values
          .cast<TarefaHiveModel>()
          .where((element) => !element.concluido)
          .toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }
}