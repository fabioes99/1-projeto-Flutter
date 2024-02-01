import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaModel {
  String descricao = "";
  bool concluido = false;
  DateTime dataCriacao = DateTime.now();
  DateTime dataAlteracao = DateTime.now();
  String userId = '';

  TarefaModel(
      {required this.descricao, required this.concluido, required this.userId});

  TarefaModel.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
    userId = json['user_id'];
    dataCriacao = (json['data_criacao'] as Timestamp).toDate();
    dataAlteracao = (json['data_alteracao'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['data_criacao'] = Timestamp.fromDate(dataCriacao);
    data['data_alteracao'] = Timestamp.fromDate(dataAlteracao);
    data['user_id'] = userId;
    return data;
  }
}