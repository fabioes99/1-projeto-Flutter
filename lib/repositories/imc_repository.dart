import 'package:_1_projeto/model/pessoa.dart';

class ImcRepository {

  final List<Pessoa> _imc  = [];

  Future<void> add(Pessoa pessoa) async{
     await Future.delayed(const Duration(seconds: 1));
    _imc.add(pessoa);
  }

  Future<void> alterarPeso(String id, double peso) async{
     await Future.delayed(const Duration(milliseconds: 200));
     _imc
        .where((tarefa) => tarefa.getId() == id)
        .first.setPeso(peso);
  }

   Future<void> alterarAltura(String id, double altura) async{
     await Future.delayed(const Duration(milliseconds: 200));
     _imc
        .where((tarefa) => tarefa.getId() == id)
        .first.setAltura(altura);
  }

  Future<void> excluir(String id) async{
     await Future.delayed(const Duration(milliseconds: 200));
     _imc.remove(
      _imc
        .where((tarefa) => tarefa.getId() == id).first);     
  }

  Future<List<Pessoa>> listar() async{
    await Future.delayed(const Duration(milliseconds: 200));
    return _imc;
  }

}