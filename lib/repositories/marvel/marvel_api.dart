import 'package:_1_projeto/model/characters.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:convert/convert.dart';

class MarvelApiRepository {

  Future<CharactersModel> getCharacters(int offset) async{
    var dio = Dio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = dotenv.get("MARVELPUBLICKEY");
    var privateKey = dotenv.get("MARVELAPIKEY");
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";
    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
        var charactersModel = CharactersModel.fromJson(result.data);
    return charactersModel;
  }

  _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}