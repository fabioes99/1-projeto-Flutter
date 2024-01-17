import 'package:_1_projeto/model/pessoa.dart';
import 'package:_1_projeto/repositories/sqlite/sqlite_database.dart';

class ImcSqliteRepository{
  Future<List<Pessoa>> obterDados() async{
    List<Pessoa> imc = [];
    var db = await SqliteDatabase().iniciarBancoDeDados();
    var result = await db.rawQuery(
      'SELECT id, peso, altura, data FROM imc' 
      );
    for (var element in result) {
      imc.add(Pessoa(
        int.parse(element['id'].toString()) ,
        element['peso'] is double ? element['peso'] as double : 0.0,
        element['altura'] is double ? element['altura'] as double : 0.0,
        element['data'].toString()) );
    }
    return imc;
  }

  Future<void> add(Pessoa imcPessoa) async{
    var db = await SqliteDatabase().iniciarBancoDeDados();
    await db.rawInsert('INSERT INTO imc (peso, altura, data) VALUES (?,?,?)',
    [imcPessoa.getPeso(), imcPessoa.getAltura(), imcPessoa.getData() ]
    );
  }

  Future<void> update(Pessoa imcPessoa) async{
    var db = await SqliteDatabase().iniciarBancoDeDados();
    await db.rawUpdate('UPDATE imc SET peso = ?, altura = ?, data = ? where id = ?',
    [imcPessoa.getPeso() , imcPessoa.getAltura(), imcPessoa.getData(), imcPessoa.getId()]
    );
  }

  Future<void> delete(int id) async{
    var db = await SqliteDatabase().iniciarBancoDeDados();
    await db.rawDelete('DELETE FROM imc where id = ?',
    [id]
    );
  }
}