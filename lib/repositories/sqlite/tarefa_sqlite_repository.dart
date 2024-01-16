import 'package:_1_projeto/model/tarefaSqlite.dart';
import 'package:_1_projeto/repositories/sqlite/sqlite_database.dart';

class TarefaSqliteRepository{
  Future<List<TarefaSqliteModel>> obterDados(bool apenasNaoConcluidos) async{
    List<TarefaSqliteModel> tarefas = [];
    var db = await SqliteDatabase().obterDataBase();
    var result = await db.rawQuery(
      apenasNaoConcluidos ? 'SELECT id, descricao, concluido FROM tarefas where concluido = 0' :
      'SELECT id, descricao, concluido FROM tarefas'
      );
    for (var element in result) {
      tarefas.add(TarefaSqliteModel(
        int.parse(element['id'].toString()) ,
        element['descricao'].toString(), 
        element['concluido'] == 1) );
    }
    return tarefas;
  }

  Future<void> add(TarefaSqliteModel tarefaSqliteModel) async{
    var db = await SqliteDatabase().obterDataBase();
    await db.rawInsert('INSERT INTO tarefas (descricao, concluido) VALUES (?,?)',
    [tarefaSqliteModel.getDescricao(), tarefaSqliteModel.getConcluido()]
    );
  }

  Future<void> update(TarefaSqliteModel tarefaSqliteModel) async{
    var db = await SqliteDatabase().obterDataBase();
    await db.rawUpdate('UPDATE tarefas SET descricao = ?, concluido = ? where id = ?',
    [tarefaSqliteModel.getDescricao(), tarefaSqliteModel.getConcluido(), tarefaSqliteModel.getId()]
    );
  }

  Future<void> delete(int id) async{
    var db = await SqliteDatabase().obterDataBase();
    await db.rawDelete('DELETE FROM tarefas where id = ?',
    [id]
    );
  }
}