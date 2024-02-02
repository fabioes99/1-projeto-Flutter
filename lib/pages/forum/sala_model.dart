class SalaModel {
  int salaId = 0;
  String titulo = "";  
  String descricao = "";  

  SalaModel({required this.salaId, required this.titulo, required this.descricao});

  SalaModel.fromJson(Map<String, dynamic> json) {
    salaId = json['sala_id'];
    titulo = json['titulo'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sala_id'] = salaId;
    data['titulo'] = titulo;
    data['descricao'] = descricao;
    return data;
  }
}