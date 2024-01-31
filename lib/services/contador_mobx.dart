import 'package:mobx/mobx.dart';

class ContadorMobxService{

  final _contador = Observable(0);
  int get contador => _contador.value;

  late Action increment;
  set value(int newValue) => _contador.value = newValue;

   void _increment() {
    _contador.value++;
  }

  ContadorMobxService() {
    increment = Action(_increment);
  }
  
}