String retornaClassificacao(double imc) {
  String classificacao = '';
  if (imc < 16) {
    classificacao = "Classificação: Baixo peso muito grave  ";
  } else if (imc >= 16 && imc < 16.9) {
    classificacao = "Classificação: Baixo peso grave  ";
  } else if (imc >= 17 && imc < 18.4) {
    classificacao = "Classificação: Baixo peso  ";
  } else if (imc >= 18.5 && imc < 24.9) {
    classificacao = "Classificação: Peso normal  ";
  } else if (imc >= 25 && imc < 29.9) {
    classificacao = "Classificação: Sobrepeso  ";
  } else if (imc >= 30 && imc < 34.9) {
    classificacao = "Classificação: Obesidade grau I  ";
  } else if (imc >= 35 && imc < 39.9) {
    classificacao = "Classificação: Obesidade grau II (severa)  ";
  } else {
    classificacao = "Classificação: Obesidade grau III (mórbida)  ";
  }

  return classificacao;
}