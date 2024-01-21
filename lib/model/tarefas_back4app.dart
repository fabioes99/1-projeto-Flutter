class Tarefa {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  Tarefa(this.objectId, this.descricao, this.concluido, this.createdAt, this.updatedAt);

  Tarefa.criar(this.descricao, this.concluido);

  Tarefa.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}

class TarefasBack4AppModel {
  late List<Tarefa> tarefas;

  TarefasBack4AppModel(this.tarefas);

  TarefasBack4AppModel.fromJson(Map<String, dynamic> json) {
    tarefas = <Tarefa>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        tarefas.add(Tarefa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}
