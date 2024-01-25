class ContatoModel {
  String? objectId = "";
  String? pathPhoto;
  String? nome;
  String? email;
  String? telefone;
  String? cpf;
  String createdAt = "";
  String updatedAt = "";

  ContatoModel(
      {
      String? objectId = "",
      String? pathPhoto,
      String? nome,
      String? email,
      String? telefone,
      String? cpf,}) {

    if(objectId != null){
      this.objectId = objectId;
    }
    if (pathPhoto != null) {
       this.pathPhoto = pathPhoto;
    }
    if (nome != null) {
       this.nome = nome;
    }
    if (email != null) {
       this.email = email;
    }
    if (telefone != null) {
       this.telefone = telefone;
    }
    if (cpf != null) {
       this.cpf = cpf;
    }
  }


  factory ContatoModel.fromJson(Map<String, dynamic> json) {
    return ContatoModel(
      objectId: json['objectId'] as String?,
      pathPhoto: json['path_photo'] as String?,
      nome: json['nome'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      cpf: json['cpf'] as String?,
    );
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['objectId'] = objectId;
    data['path_photo'] = pathPhoto;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['cpf'] = cpf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

   Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path_photo'] = pathPhoto;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['email'] = email;
    data['cpf'] = cpf;
    return data;
  }


}


class ListaContatosModel {
 late List<ContatoModel> listaContatos;

  ListaContatosModel(this.listaContatos);

  ListaContatosModel.fromJson(Map<String, dynamic> json) {
    listaContatos = <ContatoModel>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        listaContatos.add(ContatoModel.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = listaContatos.map((v) => v.toJson()).toList();
    return data;
  }

}