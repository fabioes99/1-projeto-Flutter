import 'package:mobx/mobx.dart';

part 'contador_mobx_store.g.dart';

class Contador = _Contador with _$Contador;

// The store-class
abstract class _Contador with Store {
  @observable
  int contador = 0;

  @action
  void incrementar(){
    contador++;
  }
}