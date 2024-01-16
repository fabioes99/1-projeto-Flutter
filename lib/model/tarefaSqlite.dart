class TarefaSqliteModel{
  int _id = 0;
  String _descricao = '';
  bool _concluido = false;

  TarefaSqliteModel(this._id, this._descricao, this._concluido);

  int getId(){
    return _id;
  }

  String getDescricao(){
    return _descricao;
  }

  bool getConcluido(){
    return _concluido;
  }

  void setId(int id){
    _id = id;
  }

  void setDescricao(String descricao){
    _descricao = descricao;
  }

  void setConcluido(bool concluido){
    _concluido = concluido;
  }


}