import 'package:flutter/material.dart';
import 'package:_1_projeto/utils/classificacao_imc.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;
  String _classificacao = "";
  String _data = '';

  void setPeso(double peso) => _peso = peso;
  void setAltura(double altura) => _altura = altura;
  void setImc(double imc) => _imc =  imc;
  void setClassificacao(String classificacao) => _classificacao = classificacao;
  void setData(String data) => _data = data;
  double getImc() => _imc;
  double getPeso() => _peso;
  double getAltura() => _altura;
  String getId() => _id;
  String getClassificacao() => _classificacao;
  String getData() => _data;

  Pessoa( double peso, double altura, String data){
    _peso = peso;
    _altura = altura;
    _data = data;

    try {
      _imc = calcularIMC();
      _classificacao = retornaClassificacao(_imc);
    } catch (e) {
      print("Erro ao calcular o IMC: $e");
    }
  }

  double calcularIMC( ) {
  if (_peso <= 0 || _altura <= 0) {
    throw ArgumentError("Peso e altura devem ser valores positivos.");
  }
  if ( (_peso > 630 || _peso < 2.5 ) || (_altura > 272 || _altura < 45 )) {
    throw ArgumentError("Peso e altura devem ser valores existentes.");
  }
  // Convertendo altura para metros
  double alturaMetros = _altura / 100.0;
  double imc = _peso / (alturaMetros * alturaMetros);
  double valorArredondado = double.parse(imc.toStringAsFixed(1));
  return valorArredondado;
}


 @override
  String toString(){
    return { "peso": getPeso(), "altura": getAltura() }.toString();
  }

}