import 'package:_1_projeto/model/dados_cadastrais_model.dart';
import 'package:_1_projeto/model/tarefa_hive.dart';
import 'package:_1_projeto/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:_1_projeto/repositories/sqlite/sqlite_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  SqliteDatabase database = SqliteDatabase();
  await database.iniciarBancoDeDados();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}


