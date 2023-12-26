import 'package:flutter/material.dart';

class Pessoa {
  final String _id = UniqueKey().toString();
  String _nome = '';
  double _peso = 0;
  double _altura = 0;

  void setNome(String nome) => _nome = nome;
  void setPeso(double peso) => _peso = peso;
  void setAltura(double altura) => _altura = altura;
  String getNome() => _nome;
  double getPeso() => _peso;
  double getAltura() => _altura;
  String getId() => _id;

  Pessoa(this._nome, this._peso, this._altura);

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
    return { "Nome": getNome(), "peso": getPeso(), "altura": getAltura() }.toString();
  }

}