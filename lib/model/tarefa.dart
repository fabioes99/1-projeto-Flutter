import 'package:flutter/material.dart';

class Tarefa{
  final String _id = UniqueKey().toString();
  String _descricao = '';
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  String getId(){
    return _id;
  }

  String getDescricao(){
    return _descricao;
  }

  bool getConcluido(){
    return _concluido;
  }

  void setDescricao(String descricao){
    _descricao = descricao;
  }

  void setConcluido(bool concluido){
    _concluido = concluido;
  }

  /* da para usar desta forma tambem

   bool get concluido => _concluido;

  set descricao(String descricao){
    _descricao = descricao;
  }

  */


}