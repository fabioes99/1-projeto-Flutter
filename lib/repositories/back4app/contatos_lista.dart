import 'package:_1_projeto/model/contatos.dart';
import 'back4app_custom_dio.dart';

class ListaContatosRepository {
  final _custonDio = Back4AppCustonDio();

  ListaContatosRepository();

  Future<ListaContatosModel> obterContatos(int skip) async {
    var result = await _custonDio.dio.get("/Contatos", queryParameters: { 'limit' : 8, 'skip': skip });
    ListaContatosModel cep = ListaContatosModel.fromJson(result.data);
    return cep;
  }

  Future<ContatoModel> getContato(String nome) async{
    
    var url = '/Contatos?where={"objectId": "$nome"}';
    var result = await _custonDio.dio.get(url);
    ContatoModel contato = ContatoModel.fromJson(result.data);
    return contato;
  }

  Future<void> post(ContatoModel contatoModel) async {
    try {
      var result = await _custonDio.dio.post('/Contatos', data: contatoModel.toJsonEndpoint() );
      print(result);
    } catch (e) {
      throw e;
    }
  }


  Future<void> update(ContatoModel contatoModel) async {
    String objectId = contatoModel.objectId!;
    try {
       var result = await _custonDio.dio.put('/Contatos/$objectId', data: contatoModel.toJsonEndpoint() );
    print(result);
    } catch (e) {
      throw e;
    }
   
  }

  Future<void> delete(String objectId) async {
   
    try {
      var result = await _custonDio.dio.delete('/Contatos/$objectId');
      print(result);
    } catch (e) {
      throw e;
    }
   
  }
}
