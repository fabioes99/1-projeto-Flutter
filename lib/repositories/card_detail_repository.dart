import 'package:_1_projeto/model/card_detail.dart';

class CardDetailRepository{

  Future<CardDetail> get() async {
    await Future.delayed(const Duration(seconds: 3));
    return  CardDetail(
     1 , "Meu Card", "https://hermes.digitalinnovation.one/assets/diome/logo.png","teste"
    );
  }
  
}