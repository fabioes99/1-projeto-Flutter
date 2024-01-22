import 'package:_1_projeto/model/cep_back4app.dart';
import 'back4app_custom_dio.dart';

class CEPBack4appRepository {
  final _custonDio = Back4AppCustonDio();

  CEPBack4appRepository();

  Future<CEPBack4appModel> obterCEPS(int skip) async {
    var result = await _custonDio.dio.get("/CEP", queryParameters: { 'limit' : 3, 'skip': skip });
    CEPBack4appModel cep = CEPBack4appModel.fromJson(result.data);
    return cep;
  }

  String normalizarCEP(String cep){
    String cepNormalizado = cep.replaceAll(RegExp(r'[^0-9]'), '');
    return cepNormalizado;
  }

  Future<void> post(CEP cepModel) async {
    cepModel.cep = normalizarCEP(cepModel.cep ?? '');
    try {
      var result = await _custonDio.dio.post('/CEP', data: cepModel.toJsonEndpoint() );
      print(result);
    } catch (e) {
      throw e;
    }
  }


  Future<void> update(CEP cepModel) async {
    String objectId = cepModel.objectId!;
    try {
       var result = await _custonDio.dio.put('/CEP/$objectId', data: cepModel.toJsonEndpoint() );
    print(result);
    } catch (e) {
      throw e;
    }
   
  }

  Future<void> delete(String objectId) async {
   
    try {
      var result = await _custonDio.dio.delete('/CEP/$objectId');
      print(result);
    } catch (e) {
      throw e;
    }
   
  }
}
