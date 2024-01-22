class CEP {
  String? objectId = "";
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String createdAt = "";
  String updatedAt = "";

  CEP(
      {
      String? objectId = "",
      String? cep,
      String? logradouro,
      String? complemento,
      String? bairro,
      String? localidade,
      String? uf,}) {
    
    this.objectId = objectId;
    
    if (cep != null) {
       this.cep = cep;
    }
    if (logradouro != null) {
       this.logradouro = logradouro;
    }
    if (complemento != null) {
       this.complemento = complemento;
    }
    if (bairro != null) {
       this.bairro = bairro;
    }
    if (localidade != null) {
       this.localidade = localidade;
    }
    if (uf != null) {
       this.uf = uf;
    }
  }


  factory CEP.fromJson(Map<String, dynamic> json) {
    return CEP(
      objectId: json['objectId'] as String?,
      cep: json['cep'] as String?,
      logradouro: json['logradouro'] as String?,
      complemento: json['complemento'] as String?,
      bairro: json['bairro'] as String?,
      localidade: json['localidade'] as String?,
      uf: json['uf'] as String?,
    );
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

   Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }


}


class CEPBack4appModel {
 late List<CEP> ceps;

  CEPBack4appModel(this.ceps);

  CEPBack4appModel.fromJson(Map<String, dynamic> json) {
    ceps = <CEP>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        ceps.add(CEP.fromJson(v));
      });
    }
  }

  bool verificaCEP(String cep) {
    return ceps.any((v) => v.cep == cep);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }

}