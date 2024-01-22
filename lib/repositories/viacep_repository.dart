import 'dart:convert';

import 'package:_1_projeto/model/cep_back4app.dart';
import 'package:http/http.dart' as http;
//import 'package:_1_projeto/model/viacep.dart';

class ViaCepRepository {
  Future<CEP> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return CEP.fromJson(json);
    }
    return CEP();
  }
}