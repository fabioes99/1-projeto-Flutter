import 'package:_1_projeto/model/tarefas_back4app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'back4app_custom_dio.dart';

class TarefasBack4appRepository {
  final _custonDio = Back4AppCustonDio();

  TarefasBack4appRepository();

  Future<TarefasBack4AppModel> obterTarefas(bool apenasNaoConcluidos) async {
    var url = "/Tarefas";
    if (apenasNaoConcluidos) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _custonDio.dio.get(url, queryParameters: {'order': 'descricao'});
    var tarefas = TarefasBack4AppModel.fromJson(result.data);
    return tarefas;
  }

  Future<void> post(Tarefa tarefaModel) async {
    try {
      var result = await _custonDio.dio.post('/Tarefas', data: tarefaModel.toJsonEndpoint() );
      print(result);
    } catch (e) {
      throw e;
    }
  }


  Future<void> update(Tarefa tarefaModel) async {
    String objectId = tarefaModel.objectId;
    try {
       var result = await _custonDio.dio.put('/Tarefas/$objectId', data: {"concluido": tarefaModel.concluido, "descricao": tarefaModel.descricao});
    print(result);
    } catch (e) {
      throw e;
    }
   
  }

  Future<void> delete(String objectId) async {
   
    try {
      var result = await _custonDio.dio.delete('/Tarefas/$objectId');
      print(result);
    } catch (e) {
      throw e;
    }
   
  }
}
